require 'spec_helper'

describe SearchController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
    @book = FactoryGirl.create(:valid_book)
  end

  context 'GET #index' do
    it 'should render the search page' do
      get(:index, {'filter' => 'title', 'title' => @book.title})
      response.should render_template :index
    end
  end

  it 'should return a book matching the filter' do
    @book.should_not be_nil
    get(:index, {'filter' => 'title', 'title' => @book.title})
    assigns(:books).should eq([@book])
    get(:index, {'filter' => 'author', 'title' => @book.author})
    assigns(:books).should eq([@book])
    get(:index, {'filter' => 'isbn', 'title' => @book.isbn})
    assigns(:books).should eq([@book])
  end

end
