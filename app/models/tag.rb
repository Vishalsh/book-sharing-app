class Tag < ActiveRecord::Base

  validates :name, presence: true
  has_and_belongs_to_many :books


  def self.filter_by(value)
    Tag.where(name: value.to_s).first
  end

end
