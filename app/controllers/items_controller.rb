class ItemsController < ApplicationController
	
	before_filter :login_required
	
  # GET /items
  # GET /items.xml
  def index
    @owned_items = current_user.owned_items
    @current_items = current_user.current_items

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  def add
  	@item = current_user.owned_items.build()
  	libitem = Libitem.new()
  	libitem.scrape_basic( 
  				Amazon::Ecs::Response.new(
  				current_user.results.find(:first).details).items[params[:listing_id].to_i])
  	dblibi = Libitem.find_by_asin(libitem)
  	unless dblibi
	  	libitem.save!
	  	@item.libitem_id = libitem.id
  	else
  		@item.libitem_id = dblibi
		end
  	@item.save!
  	#flash[:notice] = "Gratz!  You've added #{@item.libitem.title}"
  	redirect_to :controller => :spec, :action => :home
  end  	
end
