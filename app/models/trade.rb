class Trade < ActiveRecord::Base
	belongs_to :lender, :class_name => "User"
	belongs_to :borrower, :class_name => "User"
	belongs_to :item

	validates_presence_of :lender_id, :borrower_id

	def after_save
		self.item.save!
	end

	#Returns true if there is a trade already in progress
	def self.exists?(lender, requester, item)
		not find_by_lender_id_and_borrower_id_and_item_id_and_completed(lender, requester, item, false).nil?
	end
	
	def self.get_trade(lender, requester, item)
		find_all_by_lender_id_and_borrower_id_and_item_id_and_completed(lender, requester, item, false).last
	end
	
	def self.request(requester, item)
		unless requester == item.current_user
			if requester == item.owner		#If the person making the request is asking for it back
				#Notify the person with the item that the owner would like to have it back!
				item.wants_back = true 
				item.tradeable = 2
				item.save!
			else
				#check to make sure this isn't a useless request (requester in the queue already)
				unless item.queue.include?(requester.id)
					transaction do
						item.queue << requester.id  							#add the requester to the queue
						item.save!	
						requester.my_requests << item.id					#add the item to the requester's queue
						requester.save!
					end
				else
				  "Error!"
				end
			end
		end
	end
	
	def self.lend(lender, requester, item)
		#make sure we CAN lend it. 
		if ((lender == item.owner) || (requester == item.owner))
			if Friendship.friends?(lender, requester)
				#giving it back to owner (trade exists already)
				if t = Trade.get_trade(lender, requester, item)
					transaction do
						t.status = "incoming"
						item.tradeable = false
						item.save!
						t.save!
					end
				#giving it out to someone else
				else
					create!({:item => item, :lender => lender, :borrower => requester, :status => "outgoing"})
					item.tradeable = false
					item.save!
				end
			end
		end
	end
	
	def self.recieve(requester, item)
		#make sure the trade exists
		if t = Trade.get_trade(item.current_user, requester, item)
			if t.status == "outgoing"
				transaction do
					t.status = "recieved"
					t.location = "out"
					t.has_started = true
					item.queue = item.queue - [requester.id]						#remove from queue
					item.current_user = requester
					requester.my_requests = requester.my_requests - [item.id]
					requester.save!
					item.save!
					t.save!
				end
			end
		elsif t = Trade.get_trade(requester, item.current_user, item)
			if t.status == "incoming"
				transaction do
					t.status = "returned"
					t.location = "in"
					t.completed = true
										#set that it's been returned
					item.wants_back = false
					item.tradeable = true
					item.current_user = item.owner
					item.save!
					t.save!
				end
			end
		end
	end
	
	def self.deny(requester, item)
		if item.queue.include?(requester.id)
			transaction do
				item.queue = item.queue - [requester.id]						#remove from queue
				requester.my_requests = requester.my_requests - [item.id]
				requester.save!
				item.save!
			end
		end
	end
	
	def self.cancel(requester, item)
		Trade.deny(requester, item)
		i = Item.find(item.id)
		if t = Trade.get_trade(item.current_user, requester, item) #someone wants to borrow
			if t.status == "outgoing"
				transaction do
					t.status = "returned"
					t.location = "in"
					t.has_started = true
					t.completed = true
					i.wants_back = false
					i.tradeable = true
					i.save!
					t.save!
				end
			end
		elsif t = Trade.get_trade(requester, item.current_user, item)  #owner wants it back
			if t.status == "incoming"
				transaction do
					t.status = "recieved"
					t.location = "out"
					i.wants_back = false
					i.save!
					t.save!
				end
			end
		end
	end
		

end
