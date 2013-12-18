class CreateJoinTableBookOwner < ActiveRecord::Migration
  def change
    create_join_table :books, :owners, id: false  do |t|
      t.references :book_id
      t.references :owner_id
      # t.index [:book_id, :owner_id]
      # t.index [:owner_id, :book_id]
    end
  end
end
