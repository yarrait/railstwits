class CreateKeywordTweets < ActiveRecord::Migration
  def self.up
    create_table :keyword_tweets do |t|
      t.integer :keyword_id
      t.string :tweet_text
      t.string :tweet_id
      t.string :source
      t.string :user
      t.datetime :created_at
      t.string :tinyurl
      t.string :original_url

      t.timestamps
    end
  end

  def self.down
    drop_table :keyword_tweets
  end
end
