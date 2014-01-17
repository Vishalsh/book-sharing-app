class BookBorrower < ActiveRecord::Base

  validates :book_id, :owner_id, :borrower_id, :date_of_borrowing, presence: true
  belongs_to :borrower, class_name: User

end
