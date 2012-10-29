class CreateKeywordUrlAnalytics < ActiveRecord::Migration
  def self.up
    create_table :keyword_url_analytics do |t|
      t.integer :keyword_id
      t.integer :keyword_tweet_id
      t.string :tinyurl
      t.integer :counter

      t.timestamps
    end
  end

  def self.down
    drop_table :keyword_url_analytics
  end
end
