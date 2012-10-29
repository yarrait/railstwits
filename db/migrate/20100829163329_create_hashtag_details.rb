class CreateHashtagDetails < ActiveRecord::Migration
  def self.up
    create_table :hashtag_details do |t|
      t.integer :keyword_tweet_id
      t.integer :keyword_hashtag_id
      t.string :hashtag
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :hashtag_details
  end
end
