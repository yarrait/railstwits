class CreateTweetStatuses < ActiveRecord::Migration
  def self.up
    create_table :tweet_statuses do |t|
      t.integer :keyword_id
      t.integer :tweet_start_id
      t.integer :tweet_end_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tweet_statuses
  end
end
