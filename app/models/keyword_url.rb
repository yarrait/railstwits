class KeywordUrl < ActiveRecord::Base
belongs_to :keyword_tweet
has_many :url_details
has_many :keyword_websites
end
