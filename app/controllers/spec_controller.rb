class SpecController < ApplicationController
	
	before_filter :login_required, :only => [ :edit, :update, :home, :index ]
	
  def index
  	redirect_to :action => :home
  end
  	
  def home
  	@user = current_user
  	@title = "User Spec Index"
  end
  
  def show
  	if params[:id] = current_user
  		redirect_to :action => :home
		else
			@user = User.find_by_login(params[:id])
  	end
  end
  
  def library
  	@user = current_user
	end
  
  def settings
  	@user = current_user
  	@title = "User Settings"
  end
  
end
