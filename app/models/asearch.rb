class Asearch < ActiveRecord::BaseWithoutTable
	column :title, :string
	column :keywords, :string
	column :author, :string
	column :category, :string
	column :sort, :string, 'salesrank'
	column :response_group, :string, 'medium'
	column :actor, :string
	column :brand, :string
	column :city, :string
	column :composer, :string
	column :condition, :string
	column :conductor, :string
	column :cuisine, :string
	column :director, :string
	column :manufacturer, :string
	column :mpaarating, :string
	column :musiclabel, :string
	column :orchestra, :string
	column :publisher, :string
	column :asin, :string
	column :author, :string
	column :isbn, :string
	column :console, :string
	column :artist, :string
	
	def valid_atts
		unless category == nil
			CATEGORIES[category.to_sym]
		end
	end
	
	def validate
		errors.add("category", "Invalid, your category is #{category}") unless category =~ /(Apparel)|(Automotive)|(Baby)|(Beauty)|(Blended)|(Books)|(Classical)|(DigitalMusic)|(DVD)|(Electronics)|(GourmetFood)|(HealthPersonalCare)|(Jewelry)|(Kitchen)|(Magazines)|(Merchants)|(Miscellaneous)|(Music)|(MusicalInstruments)|(MusicTracks)|(OfficeProducts)|(OutdoorLiving)|(PCHardware)|(PetSupplies)|(Photo)|(Restaurants)|(Software)|(SportingGoods)|(Tools)|(Toys)|(VHS)|(Video)|(VideoGames)|(Wireless)|(WirelessAccessories)/
	end
	
	def asin_search
		Amazon::Ecs.item_lookup(asin)
	end
	
	
	def send_search
		args = {}
		for att in self.valid_atts
			unless att == "Keywords"
				args[att.to_s.downcase.to_sym] = self[att.to_s.downcase.to_sym]
			end
		end
		unless ((category == "Blended") || (category == "Magazines"))
			args[:sort] = sort
		end
		if (isbn || asin)
#			Amazon::Ecs.item_lookup(asin || isbn)
		else
			Amazon::Ecs.item_search("#{keywords}", {:search_index => "#{self.category||="Books"}", :response_group => "Medium"}.merge(args))
		end
		
	end
end
