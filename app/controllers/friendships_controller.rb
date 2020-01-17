class FriendshipsController < ApplicationController
	before_filter :setup_friends, :except => [:list]
	before_filter :login_required
	
	def accept
		if @user.requested_friends.include?(@friend)
			Friendship.accept(@user, @friend)
			flash[:notice] = "Friendsihp with #{@friend.login} accepted"
		else
			flash[:notice] = "No friendship request from #{@friend.login}."
		end
		redirect_back_or_default(':controller => :spec, :action => :index')
	end
	
	def decline 
  	if @user.requested_friends.include?(@friend)
  		Friendship.breakup(@user, @friend)
			flash[:notice] = "Friendsihp with #{@friend.login} declined"
		else
			flash[:notice] = "No friendship request from #{@friend.login}."
		end
		redirect_back_or_default(':controller => :spec, :action => :index')
  end  
   
  def cancel
 		if @user.pending_friends.include?(@friend)
 			Friendship.breakup(@user, @friend)
			flash[:notice] = "Friendsihp request cancelled"
		else
			flash[:notice] = "No friendship request with #{@friend.login}."
		end
		redirect_back_or_default(':controller => :spec, :action => :index')
  end
   
  def delete
 		if @user.friends.include?(@friend)
			Friendship.breakup(@user, @friend)
			flash[:notice] = "Friendsihp with #{@friend.login} declined"
		else
			flash[:notice] = "You weren't friends with #{@friend.login}."
		end
		redirect_back_or_default(':controller => :spec, :action => :index')
  end
  
  def list
  	@title = "Find your friends!"
  	@user = current_user
  end
   
   
  private
 
  def setup_friends
 		@user = current_user
 		@friend = (User.find_by_login(params[:id]))
  end
end
