class CreateTemporaryUserDetails < ActiveRecord::Migration
  def self.up
    create_table :temporary_user_details do |t|
      t.integer :keyword_id
      t.integer :keyword_tweet_id
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :temporary_user_details
  end
end
