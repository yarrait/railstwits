class HomeController < ApplicationController
include HomeHelper
require 'seer'
	def index
	    @urls = KeywordUrl.find(:all, :conditions => ['counter > 1'],:order => 'counter desc')
		@urls = @urls.paginate :page => params[:page], :per_page => 10
@hashtags = KeywordHashtag.find(:all, :conditions => ['counter > 1'], :order => 'counter desc')
	#    @hashtag_count = KeywordHashtag.find(:all, :conditions => ['counter > 1'],:order => 'counter desc')
	#	@hashtag_count = @hashtag_count.paginate :page => params[:page], :per_page => 10
		#@websites = KeywordWebsite.find(:all, :conditions => ['counter > 1'], :order => 'counter desc')
	 # @user_count = KeywordUser.find(:all, :conditions => ['counter > 1'],:order => 'counter')
		
#logger.debug @user_count.last.counter
		#@user_count = @user_count.paginate :page => params[:page], :per_page => 10
   # @hashtags = KeywordHashtag.find(:all, :conditions => ['counter > 0'], :order => 'counter desc')
	end

end
