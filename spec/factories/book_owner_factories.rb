# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :valid_book_owner, class: Owner do |f|
    name "MyString"
  end

end
