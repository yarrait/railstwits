class CreateKeywordWebsites < ActiveRecord::Migration
  def self.up
    create_table :keyword_websites do |t|
      t.integer :keyword_url_id
      t.integer :keyword_tweet_id
      t.string :website
      t.integer :counter

      t.timestamps
    end
  end

  def self.down
    drop_table :keyword_websites
  end
end
