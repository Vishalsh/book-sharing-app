class CreateJoinTableBookTag < ActiveRecord::Migration

  def self.up
    create_join_table :books, :tags, id: false  do |t|
      t.references :book
      t.references :tag
      #t.index [:book_id, :tag_id]
      #t.index [:tag_id, :book_id]
    end
  end

  def self.down
    drop_table :books_tags
  end
end
