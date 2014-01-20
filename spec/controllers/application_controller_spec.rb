require 'spec_helper'

describe 'ApplicationController' do
  
  controller do
    def index
      redirect_to '/hugga/pugga'
    end
  end

  it 'should redirect to CAS if the user is not logged in' do
    CASClient::Frameworks::Rails::Filter.fake(nil)
    get(:index).should redirect_to('https://cas.thoughtworks.com/cas/login?service=http%3A%2F%2Ftest.host%2Fanonymous%2Findex')
    end

  it 'should redirect to hugga/puuga page if the user is logged in' do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
    get(:index).should redirect_to '/hugga/pugga'
  end

  it 'should get the count of own, shared and borrowed books' do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
    user = FactoryGirl.create(:valid_book_user)
    user.books << FactoryGirl.create(:valid_book)
    FactoryGirl.create(:valid_book_borrower)
    get :index
    assigns(:own_books).should eq(1)
    assigns(:shared_books).should eq(1)
    assigns(:borrowed_books).should eq(1)
  end

end