# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :valid_book_owner, class: BookOwner do |f|
    f.user_id 'MyString'
    f.book_id {[FactoryGirl.create(:valid_book)].__id__}
  end

end
