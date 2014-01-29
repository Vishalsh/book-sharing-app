class Book < ActiveRecord::Base

  validates :title, :description, :author, presence: true
  validates :isbn, :isbn_format => true
  validates :edition, numericality: {only_integer: true}, :allow_nil => true

  has_and_belongs_to_many :owners, class_name: User, join_table: :books_owners
  has_and_belongs_to_many :tags

  def self.filter_by filter, title
    Book.where(filter + " LIKE ?", "%" + title.to_s + "%")
  end

  def save_or_update_with_user_and_tag(current_user, tag)

    if self.valid? && Tag.new(name: tag).valid?
      existing_book = Book.find_by(isbn: isbn)

      if existing_book
        existing_book.owners << User.find_or_create_by(name: current_user)
      else
        save
        owners << User.find_or_create_by(name: current_user)
        tags << Tag.find_or_create_by(name: tag)
      end
    end
  end

end

