class CreateKeywordWebsiteAnalytics < ActiveRecord::Migration
  def self.up
    create_table :keyword_website_analytics do |t|
      t.integer :keyword_id
      t.integer :keyword_tweet_id
      t.string :website
      t.integer :counter

      t.timestamps
    end
  end

  def self.down
    drop_table :keyword_website_analytics
  end
end
