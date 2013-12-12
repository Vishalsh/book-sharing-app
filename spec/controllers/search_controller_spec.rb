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

  it 'should return no results given empty title' do
    get(:index, {'search' => ''})
    assigns(:books).should eq([])
  end

  it 'should return a book matching the title' do
    book = FactoryGirl.create(:valid_book)
    book.should_not be_nil
    get(:index, {'search' => book.title})
    assigns(:books).should eq([book])
  end

end
