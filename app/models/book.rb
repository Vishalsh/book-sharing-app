class Book < ActiveRecord::Base

  validates :title, :description, :isbn, :edition, :author, presence: true
  validates :isbn, uniqueness: true
  validates :edition, numericality: {only_integer: true}
  has_and_belongs_to_many :owners
  attr_accessor :current_owner

  after_save :associate_with_owner 

  def self.find_by_title title
    if !title.nil? && !title.blank?
      Book.where("title LIKE ?" , "%" + title.to_s + "%")
    else
      []
    end
  end


  private

  def associate_with_owner
    if @current_owner.nil?
      raise "No Owner Error"
    end
    owners << Owner.find_or_create_by(name: @current_owner)
  end



end
