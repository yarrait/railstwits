class UserblocksController < ApplicationController
  include AuthenticatedSystem
  before_filter :authorize
  # GET /userblocks
  # GET /userblocks.xml
  def index
    @userblocks = Userblock.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @userblocks }
    end
  end

  # GET /userblocks/1
  # GET /userblocks/1.xml
  def show
    @userblock = Userblock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userblock }
    end
  end

  # GET /userblocks/new
  # GET /userblocks/new.xml
  def new
		if logged_in?
	    @userblock = Userblock.new
			respond_to do |format|
				format.html # new.html.erb
				format.xml  { render :xml => @userblock }
			end
		else
			flash[:notice] = "you are not authorized to view this page"
			redirect_to '/'
		end
  end

  # GET /userblocks/1/edit
  def edit
    @userblock = Userblock.find(params[:id])
  end

  # POST /userblocks
  # POST /userblocks.xml
  def create
    @userblock = Userblock.new(params[:userblock])

    respond_to do |format|
      if @userblock.save
        flash[:notice] = 'Userblock was successfully created.'
        format.html { redirect_to(:controller => 'users', :action => 'show', :login => 'current_user.login') }
        format.xml  { render :xml => @userblock, :status => :created, :location => @userblock }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @userblock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /userblocks/1
  # PUT /userblocks/1.xml
  def update
    @userblock = Userblock.find(params[:id])

    respond_to do |format|
      if @userblock.update_attributes(params[:userblock])
        flash[:notice] = 'Userblock was successfully updated.'
        format.html { redirect_to(@userblock) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @userblock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /userblocks/1
  # DELETE /userblocks/1.xml
  def destroy
    @userblock = Userblock.find(params[:id])
    @userblock.destroy

    respond_to do |format|
      format.html { redirect_to(userblocks_url) }
      format.xml  { head :ok }
    end
  end

  private

  def authorize
    if logged_in?

    else
      redirect_to :controller => 'session', :action => 'new'
    end
  end
end
