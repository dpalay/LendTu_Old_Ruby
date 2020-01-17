class MiscController < ApplicationController
	
	def index
	  @title = "Welcome To Lendtu"
	  render :action => :index, :layout => "front_page"
  end
	
	def invite
		
	end
	
	def faq
		@title = "Frequently Asked Questions"
	end
end
