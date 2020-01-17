# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
	def protect
		unless current_user
			flash[:warning] = "You must be logged in to access that page!"
		end
	end
	
	def param_posted?(sym)
		request.post? and params[sym]		
	end
  		
end
