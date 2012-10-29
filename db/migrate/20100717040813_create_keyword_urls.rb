class CreateKeywordUrls < ActiveRecord::Migration
  def self.up
    create_table :keyword_urls do |t|
      t.integer :keyword_tweet_id
      t.string :tinyurl
      t.string :original_url

      t.timestamps
    end
  end

  def self.down
    drop_table :keyword_urls
  end
end
