class CreateBookBorrowers < ActiveRecord::Migration

  def self.up
    create_table :book_borrowers do |t|
      t.integer :book_id
      t.integer :owner_id
      t.integer :borrower_id
      t.string :date_of_borrowing
      t.timestamps
    end
  end

  def self.down
    drop_table :book_borrowers
  end

end

