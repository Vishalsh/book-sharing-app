require 'spec_helper'

describe Book do

  before(:each) do
    @book = FactoryGirl.build(:valid_book)
  end

  it 'should be valid with proper values' do
    @book.should be_valid
    @book.errors.size.should be(0)
  end

  context "Validations" do
    [:title, :description, :isbn, :edition, :author].each do |attr|
      it "should not be valid without #{attr}" do
        @book[attr] = nil
        @book.should_not be_valid
        @book.errors.to_hash[attr].should_not be_nil
      end
    end
  end

  it 'should not be valid if edition is not an integer' do
    @book.edition = 'abc'
    @book.should_not be_valid
  end

  context 'Already existing' do

    it 'should not valid with an isbn number already exists' do
      expect { @book.save }.to change(Book, :count).by(1)

      expect do
        anotherBook = FactoryGirl.build(:valid_book)
        anotherBook.should_not be_valid
        anotherBook.errors.to_hash[:isbn].should_not be_nil
        anotherBooks.save
      end.to raise_error

    end

    xit 'different user should be able to add a book with an existing isbn' do
      book = FactoryGirl.create(:valid_book)
      book = FactoryGirl.create(:valid_book_with_another_owner)

      book = Book.find_by(name: book.name)
      book.owners.first.name.should == 'alladin'
      book.owners.first.name.should == 'mario'
    end


  end

  it 'is being inserted by another user'
end
