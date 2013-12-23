class Owner < ActiveRecord::Base

  validates :name, presence: true
  has_and_belongs_to_many :books

  def get_books_with_count_of_copies
    copies = books.group(:isbn).count
    return books.uniq, copies
  end

end
