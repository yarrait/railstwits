class UserDetail < ActiveRecord::Base
belongs_to :keyword
belongs_to :keyword_tweet
end
