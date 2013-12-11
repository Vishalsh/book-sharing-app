class CreateBookOwners < ActiveRecord::Migration
  def self.up
    create_table :book_owners do |t|
      t.string :user_id
      t.references :book, index:true
      t.timestamps
    end
  end

  def self.down
    drop_table :book_owners
  end
end
