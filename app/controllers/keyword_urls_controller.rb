class KeywordUrlsController < ApplicationController
include HomeHelper
#require 'twitterland'
#use_google_charts
  # GET /keyword_urls
  # GET /keyword_urls.xml
  def index
    @keyword_urls = KeywordUrl.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @keyword_urls }
    end
  end

  # GET /keyword_urls/1
  # GET /keyword_urls/1.xml
  def show
		@urs = KeywordUrl.find(:all, :conditions => ['counter > 1'])
    @tweeturl = KeywordUrl.find(:first, :joins => :keyword_tweet, :conditions => {:keyword_tweets => { :id => params[:tweetid] } })
logger.debug @tweeturl.id
#@details = Twitterland::TweetMeme.url_info(@tweeturl.original_url)
#logger.debug @details
#logger.debug @details.story.url_count
#exit
	if !@tweeturl.blank?
		@url_date = UrlDateDetail.find_all_by_keyword_url_id(@tweeturl.id)
 		@all_urls = UrlDetail.find(:all, :joins => :keyword_url, :conditions => { :keyword_urls => { :id => @tweeturl.id } })
		@all_urls = @all_urls.paginate :page => params[:page], :per_page => 10
  end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @keyword_url }
    end
  end

  # GET /keyword_urls/new
  # GET /keyword_urls/new.xml
  def new
    @keyword_url = KeywordUrl.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @keyword_url }
    end
  end

  # GET /keyword_urls/1/edit
  def edit
    @keyword_url = KeywordUrl.find(params[:id])
  end

  # POST /keyword_urls
  # POST /keyword_urls.xml
  def create
    @keyword_url = KeywordUrl.new(params[:keyword_url])

    respond_to do |format|
      if @keyword_url.save
        flash[:notice] = 'KeywordUrl was successfully created.'
        format.html { redirect_to(@keyword_url) }
        format.xml  { render :xml => @keyword_url, :status => :created, :location => @keyword_url }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @keyword_url.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /keyword_urls/1
  # PUT /keyword_urls/1.xml
  def update
    @keyword_url = KeywordUrl.find(params[:id])

    respond_to do |format|
      if @keyword_url.update_attributes(params[:keyword_url])
        flash[:notice] = 'KeywordUrl was successfully updated.'
        format.html { redirect_to(@keyword_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @keyword_url.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /keyword_urls/1
  # DELETE /keyword_urls/1.xml
  def destroy
    @keyword_url = KeywordUrl.find(params[:id])
    @keyword_url.destroy

    respond_to do |format|
      format.html { redirect_to(keyword_urls_url) }
      format.xml  { head :ok }
    end
  end
end
