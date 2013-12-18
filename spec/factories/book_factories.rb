FactoryGirl.define do

  factory :valid_book, class: Book do |f|
    f.title 'Harry Potter and The Prisoner fo Askaban'
    f.description 'Harry Potter Epic'
    f.author 'JK Rowling'
    f.isbn '123456789'
    f.edition 1
    f.current_owner 'alladin'
  end

  factory :another_valid_book, class: Book do |f|
    f.title 'Har Potter and The Prisoner fo Askaban'
    f.description 'Hrry Potter Epic'
    f.author 'JKling'
    f.isbn '1234589'
    f.edition 2
    f.current_owner 'alladin'

  end

  factory :invalid_book, class: Book do |f|
    f.title ''
    f.description 'Harry Potter Epic'
    f.author 'JK Rowling'
    f.isbn '123456789'
    f.edition 1
    f.current_owner 'alladin'
     
  end

  factory :valid_book_with_another_owner, class: Book do |f|
    f.title 'Harry Potter and The Prisoner fo Askaban'
    f.description 'Harry Potter Epic'
    f.author 'JK Rowling'
    f.isbn '123456789'
    f.edition 1
    f.current_owner 'mario'
  end

end

