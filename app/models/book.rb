class Book < ActiveRecord::Base

  validates :title, :description, :isbn, :edition, :author, presence: true
  validates :isbn, uniqueness: true
  validates :edition, numericality: {only_integer: true}
  has_and_belongs_to_many :book_owners

  def self.find_by_title title
    if !title.nil? && !title.blank?
      Book.where("title LIKE ?" , "%" + title.to_s + "%")
    else
      []
    end
  end
end
