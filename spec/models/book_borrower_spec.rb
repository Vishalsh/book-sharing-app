require 'spec_helper'

describe BookBorrower do

  before(:each) do
    @book_borrower = FactoryGirl.build(:valid_book_borrower)
  end

  it 'should be valid with proper values' do
    @book_borrower.should be_valid
    @book_borrower.errors.size.should be(0)
  end

  context "Validations" do
    [:book_id, :owner_id, :borrower_id, :date_of_borrowing].each do |attr|
      it "should not be valid without #{attr}" do
        @book_borrower[attr] = nil
        @book_borrower.should_not be_valid
        @book_borrower.errors.to_hash[attr].should_not be_nil
      end
    end
  end
end
