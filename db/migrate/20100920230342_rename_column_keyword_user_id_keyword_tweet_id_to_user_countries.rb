class RenameColumnKeywordUserIdKeywordTweetIdToUserCountries < ActiveRecord::Migration
  def self.up
		rename_column(:user_countries, :keyword_user_id, :keyword_tweet_id)
  end

  def self.down
  end
end
