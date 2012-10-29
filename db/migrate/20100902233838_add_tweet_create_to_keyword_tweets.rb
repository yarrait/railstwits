class AddTweetCreateToKeywordTweets < ActiveRecord::Migration
  def self.up
    add_column :keyword_tweets, :tweet_create, :date
  end

  def self.down
    remove_column :keyword_tweets, :tweet_create
  end
end
