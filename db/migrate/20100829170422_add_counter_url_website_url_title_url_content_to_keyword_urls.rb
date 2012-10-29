class AddCounterUrlWebsiteUrlTitleUrlContentToKeywordUrls < ActiveRecord::Migration
  def self.up
    add_column :keyword_urls, :counter, :integer
    add_column :keyword_urls, :url_website, :text
    add_column :keyword_urls, :url_title, :text
    add_column :keyword_urls, :url_content, :text
  end

  def self.down
    remove_column :keyword_urls, :url_content
    remove_column :keyword_urls, :url_title
    remove_column :keyword_urls, :url_website
    remove_column :keyword_urls, :counter
  end
end
