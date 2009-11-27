class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.integer :cid
      t.string :package
      t.string :version
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :packages
  end
end
