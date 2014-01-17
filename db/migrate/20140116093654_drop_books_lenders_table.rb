class DropBooksLendersTable < ActiveRecord::Migration

  def self.up
    drop_table :books_lenders
  end

  def self.down
    create_join_table :books, :borrowers, id: false do |t|
      t.references :book_id
      t.references :lender_id
    end
  end
end
