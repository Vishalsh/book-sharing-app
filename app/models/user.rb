class User < ActiveRecord::Base

  validates :name, presence: true
  has_and_belongs_to_many :books, join_table: :books_owners

end
