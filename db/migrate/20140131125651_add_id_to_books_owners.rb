class AddIdToBooksOwners < ActiveRecord::Migration
  def self.up
    add_column :books_owners, :id, :primary_key
  end

  def self.down
    remove_column :books_owners, :id
  end


end
