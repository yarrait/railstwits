class UserDetailsController < ApplicationController
  # GET /user_details
  # GET /user_details.xml
  def index
    @user_details = UserDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_details }
    end
  end

  # GET /user_details/1
  # GET /user_details/1.xml
  def show
    @user_detail = UserDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_detail }
    end
  end

  # GET /user_details/new
  # GET /user_details/new.xml
  def new
    @user_detail = UserDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_detail }
    end
  end

  # GET /user_details/1/edit
  def edit
    @user_detail = UserDetail.find(params[:id])
  end

  # POST /user_details
  # POST /user_details.xml
  def create
    @user_detail = UserDetail.new(params[:user_detail])

    respond_to do |format|
      if @user_detail.save
        flash[:notice] = 'UserDetail was successfully created.'
        format.html { redirect_to(@user_detail) }
        format.xml  { render :xml => @user_detail, :status => :created, :location => @user_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_details/1
  # PUT /user_details/1.xml
  def update
    @user_detail = UserDetail.find(params[:id])

    respond_to do |format|
      if @user_detail.update_attributes(params[:user_detail])
        flash[:notice] = 'UserDetail was successfully updated.'
        format.html { redirect_to(@user_detail) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_details/1
  # DELETE /user_details/1.xml
  def destroy
    @user_detail = UserDetail.find(params[:id])
    @user_detail.destroy

    respond_to do |format|
      format.html { redirect_to(user_details_url) }
      format.xml  { head :ok }
    end
  end
end
