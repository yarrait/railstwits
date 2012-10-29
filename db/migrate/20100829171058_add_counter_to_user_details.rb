class AddCounterToUserDetails < ActiveRecord::Migration
  def self.up
    add_column :user_details, :counter, :integer
  end

  def self.down
    remove_column :user_details, :counter
  end
end
