require 'spec_helper'

describe BooksController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end


  describe 'GET #new' do
    it 'should renders the #new page' do
      get :new
      response.should render_template :new
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do

      it 'creates a new book' do
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book)
        }.to change(Book, :count).by(1)
      end
    end

    it "redirects to the show new contact" do
      post :create, book: FactoryGirl.attributes_for(:valid_book)
      response.should redirect_to Book.last
    end

    context 'with invalid attributes' do

      it 'does not creates a new book' do
        expect { post :create, book: FactoryGirl.attributes_for(:invalid_book)
        }.to_not change(Book, :count)
      end
    end

    it "re-renders the new method" do
      post :create, book: FactoryGirl.attributes_for(:invalid_book)
      response.should render_template :new
    end
  end

  describe 'GET #show' do

    before(:each) do
      @book = FactoryGirl.create(:valid_book)
    end

    it 'assigns the new book to @book' do
      get :show, id: @book
      assigns(:book).should eq(@book)
    end

    it 'should render the #show page' do
      get :show, id: @book
      response.should render_template :show
    end

  end

end
