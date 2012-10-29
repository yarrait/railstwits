class AddUrlCreateToKeywordUrls < ActiveRecord::Migration
  def self.up
    add_column :keyword_urls, :url_create, :date
  end

  def self.down
    remove_column :keyword_urls, :url_create
  end
end
