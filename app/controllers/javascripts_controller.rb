class JavascriptsController < ApplicationController
	def dynamic_search_form
		@categories = CATEGORIES
	end
end
