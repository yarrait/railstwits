class CreateUrlDateDetails < ActiveRecord::Migration
  def self.up
    create_table :url_date_details do |t|
      t.integer :keyword_url_id
      t.date :url_date
      t.integer :date_counter

      t.timestamps
    end
  end

  def self.down
    drop_table :url_date_details
  end
end
