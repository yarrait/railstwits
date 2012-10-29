class CreateUserCountries < ActiveRecord::Migration
  def self.up
    create_table :user_countries do |t|
      t.integer :keyword_user_id
      t.string :country
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :user_countries
  end
end
