require 'spec_helper'

describe Book do

  before(:each) do
    @book = FactoryGirl.create(:valid_book)
  end

  it 'should valid with proper values' do
    @book.should be_valid
  end

  it 'should not valid without a title' do
    @book.title = nil
    @book.should_not be_valid
  end

  it 'should not valid without a description' do
    @book.description = nil
    @book.should_not be_valid
  end

  it 'should not valid without a isbn' do
    @book.isbn = nil
    @book.should_not be_valid
  end

  it 'should not valid without a edition' do
    @book.edition = nil
    @book.should_not be_valid
  end

  it 'should not valid with an isbn number already exists' do
    expect{FactoryGirl.create(
        :book, title: 'abcd', description: 'hello world', isbn: '123456789', edition: '1'
    )}.to raise_error
  end

end
