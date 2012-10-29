class CreateTemporaryUrls < ActiveRecord::Migration
  def self.up
    create_table :temporary_urls do |t|
      t.integer :keyword_tweet_id
      t.string :tinyurl


      t.timestamps
    end
  end

  def self.down
    drop_table :temporary_urls
  end
end
