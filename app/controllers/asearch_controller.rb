class AsearchController < ApplicationController
	
	filter_parameter_logging "details"
	before_filter :login_required
	
	def index
		redirect_to :action => :search
	end
	
	def search
		@asearch = Asearch.new
		@keys = []
		CATEGORIES.keys.each do |key| 
			@keys << [key.to_s]
			@keys.sort!
		end
	end
	
	def results
		@user = current_user
		if params[:attribute] == "details"
			search = Asearch.new(params[:asearch])
			search.category = params[:category] #TODO: This is required because the select tag is not PART of the asearch in the form
			#search.sort = params[:sort] #TODO: This is required because the select tag is not PART of the asearch in the form
			@asearch = search.send_search
				#Used when no connection:
			#@asearch = Amazon::Ecs::Response::new("<Item><Title>A First Book</Title><Author>David</Author></Item><Item><Title>A Second Book</Title></Item>")
			
				#FIXME: This worked for small return lists, but not for the large ones.  I'm gonna have to think of a better way of doing this.
			#session[:items] = @asearch.items.to_s
		elsif params[:attribute] == "asin"
			search = Asearch.new(params[:asearch])
			@asearch = search.asin_search
		end
	
		if @asearch.error
			if @asearch.error_code == "AWS.ECommerceService.NoExactMatches"
				flash[:notice] = "Amazon didn't find any matches.  This is stupid, but they're sometimes rather picky about searches.  We're working on improving our end of it, but there's only so much we can do.  I suggest modifying your search slightly, perhaps removing a space or even a whole term."
			elsif @asearch.error_code == "AWS.InvalidParameterValue"
				flash[:notice] = "ZOMG! The info you entered came up as an error! If you entered the 13 digit ISBN number, try the 10 digit one instead."
			end
			redirect_back_or_default(:controller => :asearch, :action => :search)
		end
		@searchresult = @user.results.build
		@searchresult.details = @asearch.items.to_s
		unless @searchresult.save
			flash[:notice] = "Oops!  There was some error.  We're not entirely sure what happened, but we're looking into it!"
			redirect_to :controller => :asearch, :action => :search
		end
	end
end

