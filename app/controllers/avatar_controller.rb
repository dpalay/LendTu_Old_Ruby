class AvatarController < ApplicationController
	
	before_filter :login_required
	
  def index
  	redirect_to :controller => :user, :action => :index
  end

  def upload
  	@title = "Upload your image here"
  	@user = current_user
  	if param_posted?(:avatar)
  		image = params[:avatar][:image]
  		@avatar = Avatar.new(@user, image)
  		if @avatar.save
  			flash[:notice] = "Your avatar has been uploaded"
  			redirect_to :controller => :users, :action => :index
			end
		end
  end

  def delete
  end

end
