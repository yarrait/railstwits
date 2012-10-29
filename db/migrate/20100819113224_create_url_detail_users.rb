class CreateUrlDetailUsers < ActiveRecord::Migration
  def self.up
    create_table :url_detail_users do |t|
      t.integer :url_detail_id
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
    drop_table :url_detail_users
  end
end
