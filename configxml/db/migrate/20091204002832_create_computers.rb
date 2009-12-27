class CreateComputers < ActiveRecord::Migration
  def self.up
    create_table :computers do |t|
      t.integer :cid
      t.string :cname
      t.integer :oid
      t.integer :did

      t.timestamps
    end
  end

  def self.down
    drop_table :computers
  end
end
