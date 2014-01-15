# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :valid_lender, class: Lender do |f|
    f.name 'Harry Potter'
    f.date_of_lending '22/1/2014'
  end

  factory :invalid_lender, class: Lender do |f|
    f.name ''
    f.date_of_lending '22/1/2014'
  end

end
