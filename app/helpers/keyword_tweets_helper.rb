module KeywordTweetsHelper
	def get_tweet_url(keytweetid)
		@tweet_url = KeywordUrl.find_by_keyword_tweet_id(keytweetid)
		return @tweet_url
	end

	def get_web_user(tweetid)
		@user = KeywordTweet.find(:first, :select => 'user',:conditions => ['id = ?',tweetid])
		return @user.user
	end

	def get_tweet_user(user)
		@user = UserDetail.find_by_screen_name(user)
		return @user
	end

	def get_tweet_hashtag(tweetid)
#		@hashtag = KeywordHashtag.find_all_by_keyword_tweet_id(tweetid)
		@hashtag = KeywordTweet.find_by_id(tweetid)
logger.debug @hashtag
		return @hashtag.hashtag
	end
end
