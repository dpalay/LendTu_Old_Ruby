class TradeController < ApplicationController
	before_filter :setup_terms, :except => [:lend_other, :request]
	before_filter :login_required
	
  def lend
  	if @item
	  	if @item.owner == @user
	  	  Trade.lend(@user, @friend, @item)
  		else
  			Trade.lend(@item.owner, @user, @item)
  		end
  	end
  	redirect_back_or_default(:controller => :spec, :action => :home)
  end

  def borrow
  	Trade.request(@user, @friend, @item)
  	redirect_back_or_default(:controller => :spec, :action => :home)
  end
  
  def recall
  	Trade.request(@user, @item)
  	redirect_back_or_default(:controller => :spec, :action => :home)
	end

  def recieve
  	Trade.recieve(@user, @item)
  	redirect_back_or_default(:controller => :spec, :action => :home)
  end
  
  def cancel
  	
	end
  
  def lend_other
  	
	end
	
	def queue
	  @item = Item.find_by_id(params[:id])
	  if @item
	    Trade.request(current_user, @item)
    else
      flash[:warning] = "No such item found."
    end
    redirect_back_or_default(:controller => :spec, :action => :home)
  end

   
  private
  def setup_terms
 		@user = current_user
 		@item = (Item.find_by_id(params[:id]))
 		if @item
	 		if @current_user == @item.owner
	 			@friend = User.find_by_login(params[:friend])
 			else
 				@friend = @item.owner
 			end
	 	else
 		flash[:warning] = "Uh Oh!  The item you just tried to trade doesn't exist in our database.  Our staff of fully trained monkeys are looking into the problem now!"
 		redirect_back_or_default(:controller => :spec, :action => :home)
  	end
	end
	
	
end
