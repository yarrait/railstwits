class CreateWebsiteDateDetails < ActiveRecord::Migration
  def self.up
    create_table :website_date_details do |t|
      t.integer :keyword_website_id
      t.date :website_date
      t.integer :date_counter

      t.timestamps
    end
  end

  def self.down
    drop_table :website_date_details
  end
end
