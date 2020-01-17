class Libitem < ActiveRecord::Base
	has_many :items
	serialize :author
	serialize :actor
	
	def scrape_basic(amazon_element)
		if (amazon_element.class == Amazon::Element)
			self.asin = amazon_element.get("asin")
			self.author = amazon_element.get("author")
			self.publisher = amazon_element.get("publisher")
			self.isbn = amazon_element.get("isbn")
			self.title = amazon_element.get("title")
			
			get_images(amazon_element)
		end
	end
	
	#scrape the images from Amazon's results
	def get_images(amazon_element)
		if (amazon_element.class == Amazon::Element)
			#small image
			self.small_image = amazon_element.get("smallimage/url")
			self.small_height = amazon_element.get("smallimage/height")
			self.small_width = amazon_element.get("smallimage/width")
			#medium image
			self.medium_image = amazon_element.get("mediumimage/url")
			self.medium_height = amazon_element.get("mediumimage/height")
			self.medium_width = amazon_element.get("mediumimage/width")
			#large image
			self.large_image = amazon_element.get("largeimage/url")
			self.large_height = amazon_element.get("largeimage/height")
			self.large_width = amazon_element.get("largeimage/width")
			#swatch image
			self.swatch_image = amazon_element.get("swatchimage/url")
			self.swatch_height = amazon_element.get("swatchimage/height")
			self.swatch_width = amazon_element.get("swatchimage/width")	
		end
	end
	
	def avatar
		if self.small_image == ""
			Avatar.new(self)
		end
	end
end

