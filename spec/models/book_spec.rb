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

  it 'should not be valid with an isbn number already exists' do
    expect { FactoryGirl.create(
        :book, title: 'abcd', description: 'hello world', isbn: '123456789', edition: 1
    ) }.to raise_error
  end

  it 'should not be valid if edition is not an integer' do
    @book.edition = 'abc'
    @book.should_not be_valid
  end



end
