class RemoveWrongIdColumnsFromBooksOwners < ActiveRecord::Migration

  def self.up
    remove_column :books_owners, :book_id_id
    remove_column :books_owners, :owner_id_id
  end

  def self.down
    add_column :books_owner, :book_id_id, :integer
    add_column :books_owner, :owner_id_id, :integer
  end


end
