class CreateUserDateDetails < ActiveRecord::Migration
  def self.up
    create_table :user_date_details do |t|
      t.integer :keyword_user_id
      t.date :user_date
      t.integer :date_counter

      t.timestamps
    end
  end

  def self.down
    drop_table :user_date_details
  end
end
