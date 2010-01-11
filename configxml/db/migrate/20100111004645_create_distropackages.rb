class CreateDistropackages < ActiveRecord::Migration
  def self.up
    create_table :distropackages do |t|
      t.integer :pid
      t.string :package
      t.string :version

      t.timestamps
    end
  end

  def self.down
    drop_table :distropackages
  end
end
