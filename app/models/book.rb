class Book < ActiveRecord::Base

  validates :title, :description, :isbn, :edition, presence: true
  validates :isbn, uniqueness: true
  has_and_belongs_to_many :book_owners
end
