class CreateHashtagDateDetails < ActiveRecord::Migration
  def self.up
    create_table :hashtag_date_details do |t|
      t.integer :keyword_hashtag_id
      t.date :hashtag_date
      t.integer :date_counter

      t.timestamps
    end
  end

  def self.down
    drop_table :hashtag_date_details
  end
end
