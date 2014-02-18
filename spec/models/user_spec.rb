require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.build(:valid_book_user)
  end

  it 'should be valid with proper values' do
    @user.should_not be_nil
    @user.should be_valid
    @user.errors.size.should be(0)
  end

  context 'Validations' do
    it 'should not be valid without user_name' do
      @user.name = nil
      @user.should_not be_valid
      @user.errors.to_hash[:name].should_not be_nil
    end
  end

end
