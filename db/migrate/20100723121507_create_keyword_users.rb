class CreateKeywordUsers < ActiveRecord::Migration
  def self.up
    create_table :keyword_users do |t|
      t.integer :keyword_tweet_id
      t.string :user
      t.integer :counter

      t.timestamps
    end
  end

  def self.down
    drop_table :keyword_users
  end
end
