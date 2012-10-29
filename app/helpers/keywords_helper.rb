module KeywordsHelper
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
require 'open-uri'
require 'json'
require 'hpricot'
include Geokit::Geocoders

  def get_hash_link_user(tag,tweet)
      s = []
      hash = []
      links = []
      retweet_users = []
   #   s = tag.split(" ")

    #  len = s.length
      i = 0
      j = 0
      k = 0
      z = 0
      x = 0
      r = 0
      final_link = "0"
      final_hash = "0"

      html = auto_link("#{tag}")
      doc = Hpricot.parse(html)
			@all_hashtags = KeywordHashtagAnalytics.find(:all)
     # puts doc.inspect
     (doc/:'<a>'/:'</a>').each do |link|
	#puts "link is #{link}"
      if link.inner_html != "" && !link.inner_html.blank? && !link.inner_html.nil?
       if link.inner_html.include? '#'
			  hash[j] = link.inner_html
				@got_hashtag_keyword = 0
				if !@all_hashtags.blank?
					for keyhashtag in @all_hashtags
						if keyhashtag.keyword_id == tweet.keyword_id && keyhashtag.hashtag.to_s == hash[j].to_s
							  @count = keyhashtag.counter.to_i + 1
							  keyhashtag.update_attribute('counter',keyhashtag.counter+1)
							  @got_hashtag_keyword = 1
						end
					end
					if @got_hashtag_keyword == 0
						save_hashtag(tweet,hash[j])
					end
			  else
					save_hashtag(tweet,hash[j])
				end			
	  		j += 1
       elsif link.inner_html.include? 'http://'
 	  		links[k] = link.inner_html
	  		k += 1
       else 
	  		retweet_users[r] = link.inner_html
	  		r += 1
       end
      end
     end

    if hash.length != 0
      while x < hash.length
	#puts "hashtag is #{hash[x].to_s}"	
	@got_hashtag = 0
	@allhashtags = KeywordHashtag.find(:all)
	if !@allhashtags.blank?
	  for hashtag in @allhashtags
			if !hashtag.blank?
			  if hashtag.hashtag.to_s == hash[x].to_s
			    hashtag.update_attribute('counter',hashtag.counter.to_i+1)
							@all_hashtag_date = HashtagDateDetail.find_all_by_keyword_hashtag_id(hashtag.id)
							@got_hashtag_date = 0
							if !@all_hashtag_date.blank?
								for hashtagdate in @all_hashtag_date
									if hashtagdate.hashtag_date.strftime("%d-%m-%y") == tweet.tweet_create.strftime("%d-%m-%y")
#puts "urldate = #{urldate.url_date.strftime("%d-%m-%y")}"
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} with update_attr"
										@date_hash_cnt = hashtagdate.date_counter.to_i + 1
				            hashtagdate.update_attribute('date_counter',@date_hash_cnt)
										@got_hashtag_date = 1
									end
								end
								if @got_hashtag_date == 0
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} with got_url if"
									@hash_date = HashtagDateDetail.new
									@hash_date.keyword_hashtag_id = hashtag.id
									@hash_date.date_counter = 1
									@hash_date.hashtag_date = tweet.tweet_create
									@hash_date.save
								end
							else
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} main else first time"
								@hash_date = HashtagDateDetail.new
								@hash_date.keyword_hashtag_id = hashtag.id
								@hash_date.date_counter = 1
								@hash_date.hashtag_date = tweet.tweet_create
								@hash_date.save
							end
					@hashtagdetails = HashtagDetail.new
					@hashtagdetails.keyword_tweet_id = tweet.id
					@hashtagdetails.keyword_hashtag_id = hashtag.id
					@hashtagdetails.hashtag = hashtag.hashtag
					@hashtagdetails.user = tweet.user
					@hashtagdetails.save
		      @got_hashtag = 1
			  end
			end
	  end
	  if @got_hashtag == 0
      @keyhashtag = KeywordHashtag.new
	    @keyhashtag.keyword_tweet_id = tweet.id
	    @keyhashtag.hashtag = hash[x]
      @keyhashtag.save
			@hashdate = HashtagDateDetail.new
			@hashdate.keyword_hashtag_id = @keyhashtag.id
			@hashdate.date_counter = 1
			@hashdate.hashtag_date = tweet.tweet_create
			@hashdate.save
	  end
	else
      @keyhashtag = KeywordHashtag.new
	    @keyhashtag.keyword_tweet_id = tweet.id
	    @keyhashtag.hashtag = hash[x]
      @keyhashtag.save
			@hashdate = HashtagDateDetail.new
			@hashdate.keyword_hashtag_id = @keyhashtag.id
			@hashdate.date_counter = 1
			@hashdate.hashtag_date = tweet.tweet_create
			@hashdate.save
	end
        final_hash += "," + hash[x].to_s
        x += 1
      end
     end
#puts tag
puts "links = #{links}"
#logger.debug "length = #{links.length}"
     if links.length != 0
      while z < links.length
      puts "link is #{links[z]}"
      sam = ''
#logger.debug "link[z] = #{links[z]}"
      sam = links[z].to_s.gsub("(","").gsub(")","")
      @got_url = 0
#logger.debug "sam = #{sam}"
      begin
        e = LongURL::Expander.new
        @org_url = e.expand(sam)
        @geturls = KeywordUrl.find(:all)
        if !@geturls.blank? && !@geturls.nil?
          for ur in @geturls
            if @org_url.to_s.include? "?"
									@main_url = @org_url.to_s.split("?")[0]
									if ur.original_url.to_s == @main_url.to_s
														ur.update_attribute('counter',ur.counter+1)
														ur.update_attribute('url_create',tweet.tweet_create)
														@all_url_date = UrlDateDetail.find_all_by_keyword_url_id(ur.id)
														@got_url_date = 0
														if !@all_url_date.blank?
															for urldate in @all_url_date
																if urldate.url_date.strftime("%d-%m-%y") == tweet.tweet_create.strftime("%d-%m-%y")
							#puts "mainurl urldate = #{urldate.url_date.strftime("%d-%m-%y")}"
							#puts "mainurl tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} with update_attr"
																	@date_cnt = urldate.date_counter.to_i + 1
																	urldate.update_attribute('date_counter',@date_cnt)
																	@got_url_date = 1
																end
															end
															if @got_url_date == 0
							#puts "mainurl tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} with got_url if"
																@ur_date = UrlDateDetail.new
																@ur_date.keyword_url_id = ur.id
																@ur_date.date_counter = 1
																@ur_date.url_date = tweet.tweet_create
																@ur_date.save
															end
														else
							#puts "mainurl tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} main else first time"
															@ur_date = UrlDateDetail.new
															@ur_date.keyword_url_id = ur.id
															@ur_date.date_counter = 1
															@ur_date.url_date = tweet.created_at
															@ur_date.save
														end
														@urldetails = UrlDetail.new
														@urldetails.keyword_url_id = ur.id
														@urldetails.text = tweet.tweet_text
														@urldetails.user = tweet.user
														@urldetails.tweeted_at = tweet.tweet_create
														@urldetails.tags = final_hash
														@urldetails.save
														save_url_detail_user(@urldetails)
														@got_url = 1

								#keyword_url_analytics starts
														@all_keywordurls = KeywordUrlAnalytics.find(:all)
														@got_url_keyword = 0
														if !@all_keywordurls.blank?
															for keyurl in @all_keywordurls
																if keyurl.keyword_id.to_s == tweet.keyword_id.to_s && keyurl.tinyurl.to_s == ur.original_url.to_s
																		@keyur_count = keyurl.counter.to_i + 1
																		keyurl.update_attribute('counter',keyurl.counter+1)
																		@got_url_keyword = 1
																end
															end
															if @got_url_keyword == 0
																save_url(tweet,@org_url,ur.url_title)
															end
														else
															save_url(tweet,@org_url,ur.url_title)
														end
								#keyword_url_analytics ends

									end #main_url if ends

            elsif ur.original_url.to_s == @org_url.to_s
              ur.update_attribute('counter',ur.counter+1)
              ur.update_attribute('url_create',tweet.tweet_create)
							@all_url_date = UrlDateDetail.find_all_by_keyword_url_id(ur.id)
							@got_url_date = 0
							if !@all_url_date.blank?
								for urldate in @all_url_date
									if urldate.url_date.strftime("%d-%m-%y") == tweet.tweet_create.strftime("%d-%m-%y")
#puts "urldate = #{urldate.url_date.strftime("%d-%m-%y")}"
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} with update_attr"
										@date_cnt = urldate.date_counter.to_i + 1
				            urldate.update_attribute('date_counter',@date_cnt)
										@got_url_date = 1
									end
								end
								if @got_url_date == 0
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} with got_url if"
									@ur_date = UrlDateDetail.new
									@ur_date.keyword_url_id = ur.id
									@ur_date.date_counter = 1
									@ur_date.url_date = tweet.tweet_create
									@ur_date.save
								end
							else
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} main else first time"
								@ur_date = UrlDateDetail.new
								@ur_date.keyword_url_id = ur.id
								@ur_date.date_counter = 1
								@ur_date.url_date = tweet.created_at
								@ur_date.save
							end
							@urldetails = UrlDetail.new
							@urldetails.keyword_url_id = ur.id
							@urldetails.text = tweet.tweet_text
							@urldetails.user = tweet.user
							@urldetails.tweeted_at = tweet.tweet_create
							@urldetails.tags = final_hash
							@urldetails.save
							save_url_detail_user(@urldetails)
              @got_url = 1

								#keyword_url_analytics starts
														@all_keywordurls = KeywordUrlAnalytics.find(:all)
														@got_url_keyword = 0
														if !@all_keywordurls.blank?
															for keyurl in @all_keywordurls
																if keyurl.keyword_id.to_s == tweet.keyword_id.to_s && keyurl.tinyurl.to_s == ur.original_url.to_s
																		@keyur_count = keyurl.counter.to_i + 1
																		keyurl.update_attribute('counter',keyurl.counter+1)
																		@got_url_keyword = 1
																end
															end
															if @got_url_keyword == 0
																save_url(tweet,@org_url,ur.url_title)
															end
														else
															save_url(tweet,@org_url,ur.url_title)
														end
								#keyword_url_analytics ends

            end
          end
          if @got_url == 0
            @newur = KeywordUrl.new
            if @org_url.to_s.include? "?"
							@main_url = @org_url.to_s.split("?")[0]
	            @newur.original_url = @main_url
						else
	            @newur.original_url = @org_url
						end
            @newur.keyword_tweet_id = tweet.id
            @newur.tinyurl = links[z]
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")}first time with if"
            @newur.url_create = tweet.tweet_create
	    			@url_detail = get_url_details(@org_url)
						@newur.url_title = @url_detail[0]
						@newur.url_website = @url_detail[1]
						@newur.url_content = @url_detail[2]
            @newur.save
						@url_date = UrlDateDetail.new
						@url_date.keyword_url_id = @newur.id
						@url_date.date_counter = 1
						@url_date.url_date = tweet.tweet_create
						@url_date.save
					puts "first #{@newur.original_url.to_s}"
						save_website_detail(@newur,tweet)
						save_url(tweet,@org_url,@url_detail[1])
          end
        else
          @newur = KeywordUrl.new
          @newur.keyword_tweet_id = tweet.id
          @newur.tinyurl = links[z]
          @newur.original_url = @org_url
          @newur.url_create = tweet.tweet_create
    			@url_detail = get_url_details(@org_url)
					@newur.url_title = @url_detail[0]
					@newur.url_website = @url_detail[1]
					@newur.url_content = @url_detail[2]
          @newur.save
					@url_date = UrlDateDetail.new
					@url_date.keyword_url_id = @newur.id
					@url_date.date_counter = 1
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")}  first time"
					@url_date.url_date = tweet.tweet_create
					@url_date.save
#					puts "very first #{@newur.original_url.to_s}"
					save_website_detail(@newur,tweet)
					save_url(tweet,@org_url,@url_detail[1])
	#				puts "very first #{@newur.original_url.to_s}"
        end #if get_url ends
      rescue Exception => exc
         puts "Error: #{exc.inspect}" 
         @temp_url = TemporaryUrls.new
         @temp_url.keyword_tweet_id = tweet.id
         @temp_url.tinyurl = links[z]
         @temp_url.save
      end
        final_link += "," + links[z].to_s
        z += 1
     end #while ends
   end #if ends

      #puts "user is #{twituser}"
      @all_users = KeywordUser.find(:all)
      @got_user = 0
      if !@all_users.blank? && !@all_users.nil?
				for user in @all_users
					if !user.blank?
					  if user.user == tweet.user
				      @count = user.counter.to_i + 1
		      #logger.debug "counter is #{@count}"
				      user.update_attribute('counter',@count)
  	          @got_user = 1
							@all_user_date = UserDateDetail.find_all_by_keyword_user_id(user.id)
							@got_user_date = 0
							if !@all_user_date.blank?
								for userdate in @all_user_date
									if userdate.user_date.strftime("%d-%m-%y") == tweet.tweet_create.strftime("%d-%m-%y")
#puts "urldate = #{urldate.url_date.strftime("%d-%m-%y")}"
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} with update_attr"
										@date_user_cnt = userdate.date_counter.to_i + 1
				            userdate.update_attribute('date_counter',@date_user_cnt)
										@got_user_date = 1
									end
								end
								if @got_user_date == 0
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} with got_url if"
									@user_date = UserDateDetail.new
									@user_date.keyword_user_id = user.id
									@user_date.date_counter = 1
									@user_date.user_date = tweet.tweet_create
									@user_date.save
								end
							else
#puts "tweetdate= #{tweet.tweet_create.strftime("%d-%m-%y")} main else first time"
								@user_date = UserDateDetail.new
								@user_date.keyword_user_id = user.id
								@user_date.date_counter = 1
								@user_date.user_date = tweet.tweet_create
								@user_date.save
							end
					  end
					end
				end
				if @got_user == 0
			      @keyuser = KeywordUser.new
						@keyuser.keyword_tweet_id = tweet.id
						@keyuser.user = tweet.user
			      @keyuser.save
						@usr_date = UserDateDetail.new
						@usr_date.keyword_user_id = @keyuser.id
						@usr_date.date_counter = 1
						@usr_date.user_date = tweet.tweet_create
						@usr_date.save
				end
      else
      @keyuser = KeywordUser.new
	    @keyuser.keyword_tweet_id = tweet.id
	    @keyuser.user = tweet.user
      @keyuser.save
			@usr_date = UserDateDetail.new
			@usr_date.keyword_user_id = @keyuser.id
			@usr_date.date_counter = 1
			@usr_date.user_date = tweet.tweet_create
			@usr_date.save
      end
#get user's country

      return final_link,final_hash
  end

	def save_hashtag(keytweet,hashtag)
		@hashtag_ana = KeywordHashtagAnalytics.new
		@hashtag_ana.keyword_id = keytweet.keyword_id
		@hashtag_ana.keyword_tweet_id = keytweet.id
		@hashtag_ana.hashtag = hashtag
		@hashtag_ana.counter = 1
		@hashtag_ana.save
	end

	def save_url(keytweet,keyurl,web_name)
		@url_ana = KeywordUrlAnalytics.new
		@url_ana.keyword_id = keytweet.keyword_id
		@url_ana.keyword_tweet_id = keytweet.id
		@url_ana.tinyurl = keyurl
		@url_ana.counter = 1
		@url_ana.save
#keyword_website_analytics starts
		@all_keywordwebsite = KeywordWebsiteAnalytics.find(:all)
		@got_website_keyword = 0
		if !@all_keywordwebsite.blank?
			for keywebsite in @all_keywordwebsite
				if keywebsite.keyword_id.to_s == keytweet.keyword_id.to_s && keywebsite.website.to_s == web_name.to_s
						@keywebsite_count = keywebsite.counter.to_i + 1
						keywebsite.update_attribute('counter',keywebsite.counter+1)
						@got_website_keyword = 1
				end
			end
			if @got_website_keyword == 0
				save_keyword_website_analytics(keytweet,web_name)
			end
		else
			save_keyword_website_analytics(keytweet,web_name)
		end
#keyword_website_analytics ends
	end

	def save_keyword_website_analytics(keytweet,website_name)
		@website_ana = KeywordWebsiteAnalytics.new
		@website_ana.keyword_id = keytweet.keyword_id
		@website_ana.keyword_tweet_id = keytweet.id
		@website_ana.website = website_name
		@website_ana.counter = 1
		@website_ana.save
	end

  def get_url_details(data)
#puts "url = #{data}"
	agent = Mechanize.new
	doc = agent.get(data)
	web_title = agent.page.title
	web_url = agent.page.uri.to_s.split("http://").to_s.split("/")[0]
#puts web_url
	if web_url.to_s == "https:"
		web_url = agent.page.uri.to_s.split("https://").to_s.split("/")[0]
	end
	html = agent.page.content
	doc2 = Hpricot.parse(html)
	#(doc2/ :p).each do |link|
	#	puts link.attributes
	p = doc2/ :p
	if !p.first.inner_html.nil? && !p.first.inner_html.blank?
		web_content = p.first.inner_html
	else
		web_content = p.second.inner_html
	end
#puts web_title
#puts web_url
#puts web_content
	return web_title,web_url,web_content
  end

	def save_website_detail(keyurl,web_tweet)
#puts keyurl.original_url
		@got_website = 0
    @all_sites = KeywordWebsite.find(:all)
    if !@all_sites.blank?
      for site in @all_sites
        if site.website.to_s == keyurl.url_website.to_s
          site.update_attribute('counter',site.counter+1)
          @got_website = 1

					@all_website_date1 = WebsiteDateDetail.find_all_by_keyword_website_id(site.id)
					@got_website_date1 = 0
					if !@all_website_date1.blank? && !@all_website_date1.nil?
						for websitedate in @all_website_date1
							if websitedate.website_date.strftime("%d-%m-%y") == web_tweet.tweet_create.strftime("%d-%m-%y")
								@date_websitecnt = websitedate.date_counter.to_i + 1
		            websitedate.update_attribute('date_counter',@date_websitecnt)
								@got_website_date1 = 1
							end
						end
						if @got_website_date1 == 0
puts "tweetdate= #{web_tweet.tweet_create.strftime("%d-%m-%y")} first time"
							@website_date1 = WebsiteDateDetail.new
							@website_date1.keyword_website_id = site.id
							@website_date1.date_counter = 1
							@website_date1.website_date = web_tweet.tweet_create
							@website_date1.save
						end
					else
puts "tweetdate= #{web_tweet.tweet_create.strftime("%d-%m-%y")} main else first time"
						@website_date1 = WebsiteDateDetail.new
						@website_date1.keyword_website_id = site.id
						@website_date1.date_counter = 1
						@website_date1.website_date = web_tweet.tweet_create
						@website_date1.save
					end

        end
      end
      if @got_website == 0
        @keywebsite = KeywordWebsite.new
				@str = ""
puts keyurl.url_website.to_s
				if keyurl.original_url.to_s.include? "http://"
					puts @str += "http://" + keyurl.url_website.to_s
				else
					puts @str += "https://" + keyurl.url_website.to_s
				end
				webagent = Mechanize.new
				webdoc = webagent.get(@str)
				website_title = webagent.page.title
				webhtml = webagent.page.content
				webdoc2 = Hpricot.parse(webhtml)
				#(doc2/ :p).each do |link|
				#	puts link.attributes
				#webp = webdoc2/ :p
				#if !webp.first.inner_html.nil? && !webp.first.inner_html.blank?
					#webcontent = webp.first.inner_html
				#else
				#	webcontent = webp.second.inner_html
			#	end
        @keywebsite.keyword_url_id = keyurl.id
        @keywebsite.keyword_tweet_id = keyurl.keyword_tweet_id
        @keywebsite.website = keyurl.url_website
				@keywebsite.counter = 1
				@keywebsite.title = website_title
				@keywebsite.contents = webhtml
        @keywebsite.save
				@website_date1 = WebsiteDateDetail.new
				@website_date1.keyword_website_id = @keywebsite.id
				@website_date1.date_counter = 1
				@website_date1.website_date = web_tweet.tweet_create
				@website_date1.save
      end
    else
      @keywebsite = KeywordWebsite.new
				@str = ""
puts keyurl.url_website.to_s
				if keyurl.original_url.to_s.include? "http://"
					puts @str += "http://" + keyurl.url_website.to_s
				else
					puts @str += "https://" + keyurl.url_website.to_s
				end
				webagent = Mechanize.new
				webdoc = webagent.get(@str)
				website_title = webagent.page.title
				webhtml = webagent.page.content
				webdoc2 = Hpricot.parse(webhtml)
				#(doc2/ :p).each do |link|
				#	puts link.attributes
				#webp = webdoc2/ :p
				#if !webp.first.inner_html.nil? && !webp.first.inner_html.blank?
				#	webcontent = webp.first.inner_html
				#else
				#	webcontent = webp.second.inner_html
				#end
        @keywebsite.keyword_url_id = keyurl.id
        @keywebsite.keyword_tweet_id = keyurl.keyword_tweet_id
        @keywebsite.website = keyurl.url_website
				@keywebsite.counter = 1
				@keywebsite.title = website_title
				@keywebsite.contents = webhtml
        @keywebsite.save
				@website_date1 = WebsiteDateDetail.new
				@website_date1.keyword_website_id = @keywebsite.id
				@website_date1.date_counter = 1
				@website_date1.website_date = web_tweet.tweet_create
				@website_date1.save
    end
	end


	def get_user_detail(keyword,keytweet)
		@all_keywords = UserDetail.find(:all)
		@got_user_keyword = 0
		if !@all_keywords.blank?
			for key in @all_keywords
			  if key.keyword_id == keyword.id && key.name.to_s == keytweet.user.to_s
			      @count = key.counter.to_i + 1
			      key.update_attribute('counter',key.counter+1)
			      @got_user_keyword = 1
			  end
			end
			if @got_user_keyword == 0
				save_user(keyword,keytweet)
			end
    else
			save_user(keyword,keytweet)
    end
#logger.debug @all_keywords
#exit
	end

	def save_user(keyword,keytweet)
			begin
				buffer = open("http://twitter.com/users/show/#{keytweet.user}.json").read
				result = JSON.parse(buffer)
			  @user = UserDetail.new
				@user.counter = 1
				@user.keyword_id = keyword.id
			  @user.keyword_tweet_id = keytweet.id
				@user.name = result['name']
				@user.location = result['location']
				@user.user_created_at = result['created_at']
				@user.profile_image_url = result['profile_image_url']
				@user.web_url = result['url']
				@user.followers = result['followers_count']
				@user.screen_name = result['screen_name']
				@user.description = result['description']
				doc = open("http://www.twitter.com/#{result['screen_name']}") { |f| Hpricot(f) }
				#puts doc.inspect
				following = (doc/"#following_count").inner_html
				@user.following = following
			  @user.save
				begin
								@res = GeoKit::Geocoders::GoogleGeocoder.geocode("#{result['location']}")
							#	logger.debug @res.lat
							#	logger.debug @res.lng
								@resget=Geokit::Geocoders::GoogleGeocoder.reverse_geocode("#{@res.lat},#{@res.lng}")
								arr = @resget.full_address.split(',')
								arr_country = arr.last
										@all_countries = UserCountry.find(:all)
										@got_country = 0
										if !@all_countries.blank?
											for country in @all_countries
												if country.country == arr_country
														@count = country.counter.to_i + 1
														country.update_attribute('counter',country.counter+1)
														@got_country = 1
												end
											end
											if @got_country == 0
													@country = UserCountry.new
													@country.keyword_tweet_id = keytweet.id
													@country.user_detail_id = @user.id
													@country.country = arr_country
													@country.address = arr
													@country.save
											end
										else
										@country = UserCountry.new
										@country.keyword_tweet_id = keytweet.id
										@country.user_detail_id = @user.id
										@country.country = arr_country
										@country.address = arr
										@country.save
										end
				rescue Exception => exc
		 puts "Error: #{exc.inspect}" 
					@temp_country = TemporaryUserCountry.new
					@temp_country.keyword_id = keyword.id
					@temp_country.keyword_tweet_id = keytweet.id
					@temp_country.location = result['location']
					@temp_country.user_detail_id = @user.id
					@temp_country.save
				end
      rescue Exception => exc
				puts "Error: #{exc.inspect}" 
				@temp_user = TemporaryUserDetail.new
				@temp_user.keyword_id = keyword.id
				@temp_user.keyword_tweet_id = keytweet.id
				@temp_user.user = keytweet.user
				@temp_user.save
      end
	end

	def save_url_detail_user(urldetail)
			begin
				buffer = open("http://twitter.com/users/show/#{urldetail.user}.json").read
				result = JSON.parse(buffer)
			  @user_detail = UrlDetailUser.new
				@user_detail.url_detail_id = urldetail.id
				@user_detail.name = result['name']
				@user_detail.location = result['location']
				@user_detail.user_created_at = result['created_at']
				@user_detail.profile_image_url = result['profile_image_url']
				@user_detail.web_url = result['url']
				@user_detail.followers = result['followers_count']
				@user_detail.screen_name = result['screen_name']
				@user_detail.description = result['description']
				doc = open("http://www.twitter.com/#{result['screen_name']}") { |f| Hpricot(f) }
				#puts doc.inspect
				following = (doc/"#following_count").inner_html
				@user_detail.following = following
			  @user_detail.save
      rescue Exception => exc
				#puts "Error: #{exc.inspect}" 
				@temp_url_user = TemporaryUrlDetailUser.new
				@temp_url_user.url_detail_id = urldetail.id
				@temp_url_user.user = urldetail.user
				@temp_url_user.save
      end
	end
end
