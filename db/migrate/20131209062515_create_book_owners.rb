class CreateBookOwners < ActiveRecord::Migration
  def self.up
    require 'pry';binding.pry
    create_table :book_owners do |t|
      t.string :user_id
      t.references :book, index:true
      t.timestamps
    end
  end

  def self.down
    require 'pry';binding.pry
    drop_table :book_owners
  end
end
