class CreateTemporaryUserCountries < ActiveRecord::Migration
  def self.up
    create_table :temporary_user_countries do |t|
      t.integer :keyword_id
      t.integer :keyword_tweet_id
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :temporary_user_countries
  end
end
