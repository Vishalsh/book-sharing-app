# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :valid_book_borrower, class: BookBorrower do |f|
    f.book_id 1
    f.owner_id 2
    f.borrower_id 3
    f.date_of_borrowing "22/1/2012"
  end

  factory :invalid_book_borrower, class: BookBorrower do |f|
    f.book_id nil
    f.owner_id 2
    f.borrower_id 3
    f.date_of_borrowing "22/1/2012"
  end

end
