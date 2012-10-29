class AddHashtagToKeywordTweets < ActiveRecord::Migration
  def self.up
    add_column :keyword_tweets, :hashtag, :string
  end

  def self.down
    remove_column :keyword_tweets, :hashtag
  end
end
