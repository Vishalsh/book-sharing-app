FactoryGirl.define do

  factory :valid_book, class: Book do |f|
    f.title 'Harry Potter and The Prisoner fo Azkaban'
    f.description 'Harry Potter Epic'
    f.author 'JK Rowling'
    f.isbn '0545010225'
    f.edition 1
  end

  factory :another_valid_book, class: Book do |f|
    f.title 'Har Potter and The Prisoner fo Azkaban'
    f.description 'Hrry Potter Epic'
    f.author 'JKling'
    f.isbn '054501022X'
    f.edition 2

  end

  factory :invalid_book, class: Book do |f|
    f.title ''
    f.description 'Harry Potter Epic'
    f.author 'JK Rowling'
    f.isbn '0545010225'
    f.edition 1
     
  end

  factory :valid_book_with_another_user, class: Book do |f|
    f.title 'Harry Potter and The Prisoner fo Askaban'
    f.description 'Harry Potter Epic'
    f.author 'JK Rowling'
    f.isbn '0545010225'
    f.edition 1
  end

end

