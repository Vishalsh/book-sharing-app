class RenameOwnerToUser < ActiveRecord::Migration

  def self.up
    rename_table :owners, :users
  end

  def self.down
    rename_table :users, :owners
  end
end
