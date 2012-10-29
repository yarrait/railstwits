class KeywordWebsite < ActiveRecord::Base
belongs_to :keyword_url
belongs_to :keyword_tweet
has_many :website_date_details
end
