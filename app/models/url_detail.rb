class UrlDetail < ActiveRecord::Base
belongs_to :keyword_url
has_many :url_detail_users
end
