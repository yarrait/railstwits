class CreateTemporaryUrlDetailUsers < ActiveRecord::Migration
  def self.up
    create_table :temporary_url_detail_users do |t|
      t.integer :url_detail_id
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :temporary_url_detail_users
  end
end
