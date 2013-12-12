class CreateBookOwners < ActiveRecord::Migration
  def self.up
    create_table :book_owners do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :book_owners
  end
end
