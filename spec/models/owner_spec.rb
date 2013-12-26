require 'spec_helper'

describe Owner do

  before(:each) do
    @owner = FactoryGirl.build(:valid_book_owner)
  end

  it 'should be valid with proper values' do
    @owner.should_not be_nil
    @owner.should be_valid
    @owner.errors.size.should be(0)
  end

  context 'Validations' do
    it 'should not be valid without owner_name' do
      @owner.name = nil
      @owner.should_not be_valid
      @owner.errors.to_hash[:name].should_not be_nil
    end
  end

  xit 'should return books of owner with count of their copies' do

  end
end
