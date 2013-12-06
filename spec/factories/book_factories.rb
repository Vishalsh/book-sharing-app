FactoryGirl.define do
  factory :valid_book, class: Book do |f|
    f.title 'Harry Potter and The Prisoner fo Askaban'
    f.description 'Harry Potter Epic'
    f.isbn '123456789'
    f.edition 1
  end

  factory :invalid_book, class: Book do |f|
    f.title ''
    f.description 'Harry Potter Epic'
    f.isbn '123456789'
    f.edition 1
  end

end

