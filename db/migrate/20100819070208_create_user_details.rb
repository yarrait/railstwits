class CreateUserDetails < ActiveRecord::Migration
  def self.up
    create_table :user_details do |t|
      t.integer :keyword_id
      t.integer :keyword_tweet_id
      t.string :name
      t.string :location
      t.date :user_created_at
      t.text :profile_image_url
      t.text :web_url
      t.integer :followers
      t.integer :following
      t.text :description
      t.string :screen_name

      t.timestamps
    end
  end

  def self.down
    drop_table :user_details
  end
end
