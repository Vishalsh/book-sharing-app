require 'spec_helper'

describe User do

  before(:each) do
    @tag = FactoryGirl.build(:valid_tag)
  end

  it 'should be valid with proper values' do
    @tag.should_not be_nil
    @tag.should be_valid
    @tag.errors.size.should be(0)
  end

  context 'Validations' do
    it 'should not be valid without user_name' do
      @tag.name = nil
      @tag.should_not be_valid
      @tag.errors.to_hash[:name].should_not be_nil
    end
  end

  context 'search' do
    it 'should search for the tag' do
      tag = FactoryGirl.create(:valid_tag)
      expect(Tag.filter_by('rails').name).to eq(tag.name)
    end
  end

end
