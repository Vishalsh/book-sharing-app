class Book < ActiveRecord::Base

  validates :title, :description, :isbn, :edition, :author, presence: true
  #validates :isbn, uniqueness: true
  validates :edition, numericality: {only_integer: true}
  has_and_belongs_to_many :owners

 def self.find_by_title title
    if !title.nil? && !title.blank?
      Book.where("title LIKE ?" , "%" + title.to_s + "%")
    else
      []
    end
  end

  def save_or_update_with_owner
    if block_given?
      current_owner = yield()
    end
    existing_book = Book.find_by(isbn: isbn)
    
    if existing_book 
      existing_book.owners << Owner.find_or_create_by(name: current_owner)
    else
      if valid?
        save
        owners << Owner.find_or_create_by(name: current_owner)
      end
    end
  end 



end
