# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :valid_book_user, class: User do |f|
    name 'alladin'
  end

  factory :another_valid_book_user, class: User do |f|
    name 'jasmine'
  end

end
