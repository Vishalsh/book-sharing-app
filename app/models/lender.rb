class Lender < ActiveRecord::Base

  validates :name, :date_of_lending, presence: true
  has_and_belongs_to_many :books

end
