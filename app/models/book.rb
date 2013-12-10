class Book < ActiveRecord::Base

  validates :title, :description, :isbn, :edition, presence: true
  validates :isbn, uniqueness: true
  validates :edition, numericality: {only_integer: true}

end
