class CreateJoinTableBookLender < ActiveRecord::Migration

  def self.up
    create_join_table :books, :lenders, id: false do |t|
      t.references :book_id
      t.references :lender_id
    end
  end

  def self.down
    drop_table :books_lenders
  end
end
