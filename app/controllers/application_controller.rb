# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

   before_filter :side_bar
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

private
	def side_bar
		@user_count = KeywordUser.find(:all, :conditions => ['counter > 1'],:order => 'counter desc', :limit => 5)
    @hashtags = KeywordHashtag.find(:all, :conditions => ['counter > 1'], :order => 'counter desc')
		@websites = KeywordWebsite.find(:all, :conditions => ['counter > 1'], :order => 'counter desc', :limit => 5)
	end
end
