class KeywordTweetsController < ApplicationController
include KeywordTweetsHelper
  # GET /keyword_tweets
  # GET /keyword_tweets.xml
  protect_from_forgery :only => [:create, :update, :destroy]
  def index
    @keyword_tweets = KeywordTweet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @keyword_tweets }
    end
  end

  # GET /keyword_tweets/1
  # GET /keyword_tweets/1.xml
  def show
    @keyword_tweet = KeywordTweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @keyword_tweet }
    end
  end

	def tweetuser
	  @users = KeywordUser.find(:all, :conditions => ['counter > 1'],:order => 'counter desc')
	end

	def user_detail
		@user = UserDetail.find_by_screen_name(params[:user])
		@tweets = KeywordTweet.find_all_by_user(params[:user])
		@tweets = @tweets.paginate :page => params[:page], :per_page => 10
		@user_date = UserDateDetail.find(:all, :joins => :keyword_user, :conditions => { :keyword_users => { :user => params[:user] } })	
	end

	def websites
		@websites = KeywordWebsite.find(:all, :conditions => ['counter > 1'],:order => 'counter desc')
	end

	def website_detail
		@website = KeywordWebsite.find_by_id(params[:id])
		@urltweets = KeywordUrl.find_all_by_url_website(@website.website)
		@web_hashtags = []
		@i = 0
		for tweet in @urltweets
			@hash = get_tweet_hashtag(tweet.keyword_tweet_id)
			if !@hash.blank?
				@h = @hash.split(',')
				@h.delete(@h[0])
				@j = 0
				while @j < @h.length
					@web_hashtags[@i] = @h[@i]
					@j += 1
					@i += 1
				end
			end
		end
		@website_date = WebsiteDateDetail.find(:all, :joins => :keyword_website, :conditions => { :keyword_websites => { :id => @website.id } },:order => 'date_counter desc')

	end

	def hashtag_detail
    @hashtag = '/hashtag/'+ params[:hashtag].to_s
    respond_to do |format|
        format.json { render :json => @hashtag }      
    end
  end
	
	def hashtag
		@name = params[:name].to_s
		@hash = '#' + params[:name].to_s
		#logger.debug @hash
		@all_hash = KeywordHashtag.find(:all)
		for hash in @all_hash
			if hash.hashtag.to_s == @hash.to_s
				@key_hashid = hash.id
			end
		end
#for h in @hashtag_date
logger.debug @key_hashid
#end
#exit
		@hash_detail = HashtagDetail.find_all_by_keyword_hashtag_id(@key_hashid)
		@hashtag_date = HashtagDateDetail.find(:all, :joins => :keyword_hashtag, :conditions => { :keyword_hashtags => { :id => @key_hashid } },:order => 'date_counter desc')	

	end

  # GET /keyword_tweets/new
  # GET /keyword_tweets/new.xml
  def new
    @keyword_tweet = KeywordTweet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @keyword_tweet }
    end
  end

  # GET /keyword_tweets/1/edit
  def edit
    @keyword_tweet = KeywordTweet.find(params[:id])
  end

  # POST /keyword_tweets
  # POST /keyword_tweets.xml
  def create
    @keyword_tweet = KeywordTweet.new(params[:keyword_tweet])

    respond_to do |format|
      if @keyword_tweet.save
        flash[:notice] = 'KeywordTweet was successfully created.'
        format.html { redirect_to(@keyword_tweet) }
        format.xml  { render :xml => @keyword_tweet, :status => :created, :location => @keyword_tweet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @keyword_tweet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /keyword_tweets/1
  # PUT /keyword_tweets/1.xml
  def update
    @keyword_tweet = KeywordTweet.find(params[:id])

    respond_to do |format|
      if @keyword_tweet.update_attributes(params[:keyword_tweet])
        flash[:notice] = 'KeywordTweet was successfully updated.'
        format.html { redirect_to(@keyword_tweet) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @keyword_tweet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /keyword_tweets/1
  # DELETE /keyword_tweets/1.xml
  def destroy
    @keyword_tweet = KeywordTweet.find(params[:id])
    @keyword_tweet.destroy

    respond_to do |format|
      format.html { redirect_to(keyword_tweets_url) }
      format.xml  { head :ok }
    end
  end
end
