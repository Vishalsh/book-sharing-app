class Book < ActiveRecord::Base

  validates :title, :description, :isbn, :edition, :author, presence: true
  validates :edition, numericality: {only_integer: true}

  has_and_belongs_to_many :owners
  has_and_belongs_to_many :lenders

  def self.filter_by filter, title
    Book.where(filter + " LIKE ?", "%" + title.to_s + "%")
  end

  def save_or_update_with_owner
    if block_given?
      current_owner = yield()
    end

    if valid?
      existing_book = Book.find_by(isbn: isbn)

      if existing_book
        existing_book.owners << Owner.find_or_create_by(name: current_owner)
      else
        save
        owners << Owner.find_or_create_by(name: current_owner)
      end
    end
  end

end

