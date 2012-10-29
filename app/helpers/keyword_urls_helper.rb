module KeywordUrlsHelper

	def get_url_user(user)
		@user = UrlDetailUser.find_by_screen_name(user)
		return @user
	end

	def get_tweet_user_detail(twitid)
		@user = UserDetail.find_by_keyword_tweet_id(twitid)
		return @user
	end
end
