namespace :server do

	desc 'Fetch tweets'
  task :fetch_tweets => :environment do

		require 'rubygems'
		include KeywordsHelper
		gem('twitter4r', '>=0.2.0')
		require('twitter') 
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


		#require 'net/http'
		#require 'net/https'
#		gem('twitter4r', '>=0.2.0')
#		require('twitter')
	  #require 'open-uri'
		@keywords = Keyword.find(:all)
		@block_users = Userblock.all
		@@rpp = 50
		if !@keywords.blank?
			for keyword in @keywords
#      	begin
						client = Twitter::Client.new
						@tag = client.search(:q => "#{keyword.name}", :rpp => @@rpp)
						if !@tag.blank?
			          @keyword_tweets = KeywordTweet.find_all_by_keyword_id(keyword.id)
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
											@keytweet.update_attribute('tinyurl',@val[0])
											@keytweet.update_attribute('hashtag',@val[1])
										end
									end #@got_twitid if ends
								end #tag for loop ends

								@first_tag = @tag.first
								@last_tag = @tag.last
								@first_tweet = KeywordTweet.find_by_tweet_id(@first_tag.id)
								@last_tweet = KeywordTweet.find_by_tweet_id(@last_tag.id)
								@state = TweetStatus.new
								@state.keyword_id = keyword.id
								@state.tweet_start_id = @first_tweet.id
								@state.tweet_end_id = @last_tweet.id
								@state.save
								puts "state #{@state.id} saved!!"
						end #if !@tag.blank ends
#		    rescue Exception => exc
#		       puts "Error: #{exc.inspect}" 
#		    end
			end # keyword for loop ends
		end # keyword if loop ends

		def get_hash_link_user(tag,keytweet)
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
				 # puts doc.inspect
				 (doc/:'<a>'/:'</a>').each do |link|
			#puts "link is #{link}"
				  if link.inner_html != "" && !link.inner_html.blank? && !link.inner_html.nil?
				   if link.inner_html.include? '#'
						hash[j] = link.inner_html
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
				    final_hash += "," + hash[x].to_s
				    x += 1
				  end
				end

				 if links.length != 0
				  while z < links.length
				    final_link += "," + links[z].to_s
				    z += 1
				  end
				 end

				  return final_link,final_hash
		end

	end
end
