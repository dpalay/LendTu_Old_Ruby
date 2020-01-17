class Avatar < ActiveRecord::Base
	# Image directories
	URL_STUB = "/images/avatars"
	DIRECTORY = File.join("public", "images", "avatars")
	
	def initialize(user, image = nil)
		@user = user
		@image = image
		Dir.mkdir(DIRECTORY) unless File.directory?(DIRECTORY)
	end
	
	def exists?
		File.exists?(File.join(DIRECTORY, filename))
	end
	
	alias exist? exists?
	
	def url
		"#{URL_STUB}/#{filename}"
	end
	
	def thumbnail_url
		"#{URL_STUB}/#{thumbnail_name}"
	end
	
	
	private
	
	#Return the filename of the main avatar
	def filename
		if @user.class == User 
			"#{@user.screen_name}.png"
		elsif @user.class == Libitem
			"#{@user.title}_#{@user.id}.png"
		end
	end
	
	def thumbnail_name
		if @user.class == User 
			"#{@user.screen_name}_thumbnail.png"
		elsif @user.class == Libitem
			"#{@user.title}_#{@user.id}_thumbnail.png"
		end
	end
	
	def convert
		if ENV["OS"] =~ /Windows/
			"C:\\Program Files\\ImageMagick-6.5.2-Q16\\convert"
		else
			"/usr/bin/convert"
		end
	end
end