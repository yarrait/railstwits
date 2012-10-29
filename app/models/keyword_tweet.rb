class KeywordTweet < ActiveRecord::Base
has_many :keyword_urls
has_many :user_details
has_many :keyword_websites
has_many :hashtag_details
end
