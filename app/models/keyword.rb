class Keyword < ActiveRecord::Base
has_many :keyword_tweets
has_many :user_details
end
