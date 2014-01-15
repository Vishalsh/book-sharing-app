require 'spec_helper'

describe Lender do

  before(:each) do
    @lender = FactoryGirl.build(:valid_lender)
  end

  it 'should be valid with proper values' do
    @lender.should be_valid
    @lender.errors.size.should be(0)
  end

  context "Validations" do
    [:name, :date_of_lending].each do |attr|
      it "should not be valid without #{attr}" do
        @lender[attr] = nil
        @lender.should_not be_valid
        @lender.errors.to_hash[attr].should_not be_nil
      end
    end
  end

end
