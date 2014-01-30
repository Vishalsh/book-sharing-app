require 'spec_helper'

describe SearchController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
    @book = FactoryGirl.create(:valid_book)
  end

  context 'GET #index' do
    it 'should render the search page' do
      get(:index, {'filter' => 'title', 'value' => @book.title})
      response.should render_template :index
    end
  end

  it 'should return the books matching the filter' do
    @book.should_not be_nil
    get(:index, {'filter' => 'title', 'value' => @book.title})
    assigns(:books).should eq([@book])
    get(:index, {'filter' => 'author', 'value' => @book.author})
    assigns(:books).should eq([@book])
    get(:index, {'filter' => 'isbn', 'value' => @book.isbn})
    assigns(:books).should eq([@book])
  end

  it 'should return the books matching with the tag as the filter' do
    tag = FactoryGirl.create(:valid_tag)
    tag.books << @book
    get(:index, {'filter' => 'tag', 'value' => 'rails'})
    assigns(:books).should eq([@book])
  end

  it 'should return the empty array if there is not matching tag when tag is used as the filter' do
    tag = FactoryGirl.create(:valid_tag)
    get(:index, {'filter' => 'tag', 'value' => 'html'})
    assigns(:books).should eq([])
  end

end
