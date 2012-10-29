class AddUserDetailIdToUserCountries < ActiveRecord::Migration
  def self.up
    add_column :user_countries, :user_detail_id, :integer
  end

  def self.down
    remove_column :user_countries, :user_detail_id
  end
end
