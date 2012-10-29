class CreateUrlDetails < ActiveRecord::Migration
  def self.up
    create_table :url_details do |t|
      t.integer :keyword_url_id
      t.string :user
      t.date :tweeted_at
      t.string :tags
      t.string :retweet_user

      t.timestamps
    end
  end

  def self.down
    drop_table :url_details
  end
end
