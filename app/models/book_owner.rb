class BookOwner < ActiveRecord::Base

  validates :user_id, :book_id, presence: true
  has_and_belongs_to_many :books

end
