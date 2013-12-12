require 'spec_helper'

describe SearchController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  context 'GET #index' do
    it 'should render the search page' do
      get :index
      response.should render_template :index
    end
  end

    it 'should get the text input' do
      books = FactoryGirl.create(:valid_book)
      books.should_not be_nil
      get :index
      assigns(:books).should eq([books])
    end

end
