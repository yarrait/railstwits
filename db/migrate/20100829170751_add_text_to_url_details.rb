class AddTextToUrlDetails < ActiveRecord::Migration
  def self.up
    add_column :url_details, :text, :text
  end

  def self.down
    remove_column :url_details, :text
  end
end
