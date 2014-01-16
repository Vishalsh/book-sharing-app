class RenameOwnerIdToUserId < ActiveRecord::Migration

  def self.up
    rename_column :books_owners, :owner_id, :user_id
  end

  def self.down
    rename_column :books_owners, :user_id, :owner_id
  end

end
