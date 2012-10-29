class CreateUserblocks < ActiveRecord::Migration
  def self.up
    create_table :userblocks do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :userblocks
  end
end
