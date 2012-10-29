class AddCounterToUserCountries < ActiveRecord::Migration
  def self.up
    add_column :user_countries, :counter, :integer
  end

  def self.down
    remove_column :user_countries, :counter
  end
end
