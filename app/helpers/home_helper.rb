module HomeHelper

	def get_user_image(keytweet_id)
puts keytweet_id
		@user_image = UserDetail.find_by_keyword_tweet_id(keytweet_id)
		return @user_image
	end

	def get_hashtag(keytweet_id)
		@hashtags = KeywordHashtag.find_all_by_keyword_tweet_id(keytweet_id)
		return @hashtags
	end
=begin
	def get_comments(urlid)
		@comments = Comment.find_all_by_comment_type_id(urlid)
	end
=end
	def get_top_user(user)
 		@today = Date.today()
		@d = @today.to_date - user.created_at.to_date
		if @d <= 1
			@current = Time.now.hour()
			@user_create = user.created_at.hour()
			@diff = @current-@user_create		
			#logger.debug @diff
			if @diff <= 24
			#	return user.id
			end
		end
	return user.id
	end

	def get_top_user_info(userid)
		@keyworduser = KeywordUser.find_by_id(userid.to_i)
		@userdetail = UserDetail.find_by_keyword_tweet_id(@keyworduser.keyword_tweet_id)
		return @userdetail
	end

	def get_top_website(keytweetid)
		@keytweet = KeywordTweet.find_by_id(keytweetid)
 		@today = Date.today()
		@d = @today.to_date - @keytweet.created_at.to_date
		if @d <= 1
			@current = Time.now.hour()
			@web_create = @keytweet.created_at.hour()
			@diff = @current-@web_create		
			#logger.debug @diff
			if @diff <= 24
		#		return keytweetid
			end
		end
		return keytweetid
	end

	def get_top_website_info(tweetid)
		@webdetail = KeywordUrl.find_by_keyword_tweet_id(tweetid)
logger.debug @webdetail
#exit
		return @webdetail
	end

	def get_website(urlid)
		@website = KeywordWebsite.find_by_keyword_url_id(urlid)
		return @website
	end

end
