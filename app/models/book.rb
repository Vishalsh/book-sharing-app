class Book < ActiveRecord::Base

  validates :title, :description, :isbn, :edition, :author, presence: true
  validates :isbn, uniqueness: true
  validates :edition, numericality: {only_integer: true}
  has_and_belongs_to_many :book_owners


  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
