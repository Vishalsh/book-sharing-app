# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :valid_tag, class: Tag do |f|
    name 'rails'
  end

end
