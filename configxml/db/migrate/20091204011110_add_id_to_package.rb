class AddIdToPackage < ActiveRecord::Migration
  def self.up
    add_column :packages, :computer_id, :integer
  end

  def self.down
    remove_column :packages, :computer_id
  end
end
