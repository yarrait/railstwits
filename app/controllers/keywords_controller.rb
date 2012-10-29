class KeywordsController < ApplicationController
  include AuthenticatedSystem
  before_filter :authorize
include KeywordsHelper
gem 'twitter4r'
require 'twitter' 
require 'expurrel'
require 'longurl'
require 'twitter-text'
require 'mechanize'
require 'hpricot'
require 'nokogiri'
require 'open-uri'
#include Twitter
include Twitter::Extractor
include Twitter::Autolink

@@rpp = 100
#include KeywordsHelper
  # GET /keywords
  # GET /keywords.xml
  def index
    @keywords = Keyword.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @keywords }
    end
  end

  # GET /keywords/1
  # GET /keywords/1.xml
  def show
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @keyword }
    end
  end

  # GET /keywords/new
  # GET /keywords/new.xml
  def new
		if logged_in?
	    @keyword = Keyword.new
		  respond_to do |format|
		    format.html # new.html.erb
		    format.xml  { render :xml => @keyword }
		  end
		else
			flash[:notice] = "you are not authorized to view this page"
			redirect_to '/'
		end
  end

  # GET /keywords/1/edit
  def edit
    @keyword = Keyword.find(params[:id])
  end

  # POST /keywords
  # POST /keywords.xml
  def create
    @all_keywords = Keyword.find(:all)
		@block_users = Userblock.all
    @keyword = Keyword.new(params[:keyword])
    @got_keyword = 0
    if !@all_keywords.blank?
      for keyword in @all_keywords
        if params[:keyword][:name].to_s == keyword.name.to_s
          @got_keyword = 1
          @keyword_tweets = KeywordTweet.find_all_by_keyword_id(keyword.id)
          client = Twitter::Client.new
          @tag = client.search(:q => "#{@keyword.name}", :rpp => @@rpp)
					for tag in @tag
						@got_twitid = 0
						@got_blockuser = 0
						for keyword_tweet in @keyword_tweets
							if keyword_tweet.tweet_id.to_s == tag.id.to_s
							  @got_twitid = 1		    
							end #keyword_tweetd_id match if ends
						end #keyword_tweet for loop ends

						for block_user in @block_users
							if block_user.name.to_s == tag.from_user.to_s
							  @got_blockuser = 1		    
							end #block_user match if ends
						end #block_user for loop ends

						if @got_twitid == 0 && @got_blockuser == 0
							@keytweet = KeywordTweet.new
							puts tag
							@keytweet.keyword_id = keyword.id
							@keytweet.tweet_text = tag.text      
							@keytweet.tweet_id = tag.id
							@keytweet.source = tag.source
							@keytweet.created_at = tag.created_at
							@keytweet.tweet_create = tag.created_at
							@keytweet.user = tag.from_user
							if @keytweet.save
								@val = get_hash_link_user(tag.text,@keytweet)
								@user = get_user_detail(keyword,@keytweet)
				 		 #   @country = get_user_country(@keytweet.id,@keytweet.user)
								@keytweet.update_attribute('tinyurl',@val[0])
								@keytweet.update_attribute('hashtag',@val[1])
							end
						end #@got_twitid if ends
					end #tag for loop ends

        end # keyword match if ends
      end # @all_keywords for loop ends
	  if @got_keyword == 0
	    if @keyword.save
				client = Twitter::Client.new
				@tag = client.search(:q => "#{@keyword.name}", :rpp => @@rpp)
				for tag in @tag

					@got_blockuser = 0		    
					for block_user in @block_users
						if block_user.name.to_s == tag.from_user.to_s
						  @got_blockuser = 1		    
						end #block_user match if ends
					end #block_user for loop ends				
					if @got_blockuser == 0

							@keytweet = KeywordTweet.new
							puts tag
							@keytweet.keyword_id = @keyword.id
							@keytweet.tweet_text = tag.text      
							@keytweet.tweet_id = tag.id
							@keytweet.source = tag.source
							@keytweet.created_at = tag.created_at
							@keytweet.tweet_create = tag.created_at
							@keytweet.user = tag.from_user
							if @keytweet.save
								@val = get_hash_link_user(tag.text,@keytweet)
								@user = get_user_detail(@keyword,@keytweet)
					#			@country = get_user_country(@keytweet.id,@keytweet.user)
								@keytweet.update_attribute('tinyurl',@val[0])
								@keytweet.update_attribute('hashtag',@val[1])
							end
					end #block_user if ends
				 end # tag for loop ends
	    end # keyword save if ends
	  end # @got_keyword if ends
          respond_to do |format|
            flash[:notice] = 'Keyword was successfully created.'
            format.html { redirect_to(:controller => 'users', :action => 'show', :login => current_user.login) }
            format.xml  { render :xml => @keyword, :status => :created, :location => @keyword }
          end # respond_to ends
    else   
      if @keyword.save
          client = Twitter::Client.new
          @tag = client.search(:q => "#{@keyword.name}", :rpp => @@rpp)
          for tag in @tag

						@got_blockuser = 0		    
						for block_user in @block_users
							if block_user.name.to_s == tag.from_user.to_s
								@got_blockuser = 1		    
							end #block_user match if ends
						end #block_user for loop ends				
						if @got_blockuser == 0

				        @keytweet = KeywordTweet.new
				        puts tag
				        @keytweet.keyword_id = @keyword.id
				        @keytweet.tweet_text = tag.text      
				        @keytweet.tweet_id = tag.id
				        @keytweet.source = tag.source
				        @keytweet.created_at = tag.created_at
								@keytweet.tweet_create = tag.created_at
				        @keytweet.user = tag.from_user
				        if @keytweet.save
					        @val = get_hash_link_user(tag.text,@keytweet)
									@user = get_user_detail(@keyword,@keytweet)
					#				@country = get_user_country(@keytweet.id,@keytweet.user)
					        @keytweet.update_attribute('tinyurl',@val[0])
					        @keytweet.update_attribute('hashtag',@val[1])
								end
						end #block_user if ends
           end
          respond_to do |format|
            flash[:notice] = 'Keyword was successfully created.'
            format.html { redirect_to(:controller => 'users', :action => 'show', :login => current_user.login) }
            format.xml  { render :xml => @keyword, :status => :created, :location => @keyword }
          end
      else
         respond_to do |format|
            format.html { render :action => "new" }
            format.xml  { render :xml => @keyword.errors, :status => :unprocessable_entity }
          end
      end  # keyword save if ends  
        
    end #@all_keywords.blank? if ends

  end


  # PUT /keywords/1
  # PUT /keywords/1.xml
  def update
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      if @keyword.update_attributes(params[:keyword])
        flash[:notice] = 'Keyword was successfully updated.'
        format.html { redirect_to(@keyword) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @keyword.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.xml
  def destroy
    @keyword = Keyword.find(params[:id])
    @keyword.destroy

    respond_to do |format|
      format.html { redirect_to(keywords_url) }
      format.xml  { head :ok }
    end
  end

  private

  def authorize
    if logged_in?

    else
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end

end
