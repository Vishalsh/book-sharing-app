class Book < ActiveRecord::Base

  validates :title, :description, :isbn, :edition, presence: true
  validates :isbn, uniqueness: true

end
