class RenameBookOwnerToOwner < ActiveRecord::Migration

  def self.up
    rename_table :book_owners, :owners
  end

  def self.down
    rename_table  :owners, :book_owners
  end
end
