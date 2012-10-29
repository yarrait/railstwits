class AddTitleContentsToKeywordWebsites < ActiveRecord::Migration
  def self.up
    add_column :keyword_websites, :title, :text
    add_column :keyword_websites, :contents, :text
  end

  def self.down
    remove_column :keyword_websites, :contents
    remove_column :keyword_websites, :title
  end
end
