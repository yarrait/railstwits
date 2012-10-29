class AddUserDetailIdToTemporaryUserCountries < ActiveRecord::Migration
  def self.up
    add_column :temporary_user_countries, :user_detail_id, :integer
  end

  def self.down
    remove_column :temporary_user_countries, :user_detail_id
  end
end
