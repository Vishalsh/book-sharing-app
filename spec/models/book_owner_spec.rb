require 'spec_helper'

describe BookOwner do

  before(:each) do
     @bookOwner = FactoryGirl.build(:valid_book_owner)
    end

    it 'should be valid with proper values' do
      @bookOwner.should_not be_nil
      @bookOwner.should be_valid
      @bookOwner.errors.size.should be(0)
    end

    context "Validations" do
      [:user_id , :book_id].each do |attr|
        it "should not be valid without #{attr}" do
          @bookOwner[attr] = nil
          @bookOwner.should_not be_valid
          @bookOwner.errors.to_hash[attr].should_not be_nil
          pp @bookOwner[:book_id]
        end
      end
    end

  it "should respond to the book_id method" do
    raise "Book Id doesnt exist" if @bookOwner.nil? || @bookOwner[:book_id].nil?
  end

  xit 'should not own a non-existing book' do
  end

end
