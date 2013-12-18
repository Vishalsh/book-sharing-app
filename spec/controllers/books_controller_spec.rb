require 'spec_helper'

describe BooksController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  describe 'GET #new' do
    it 'should render the #new page' do
      get :new
      response.should render_template :new
    end
  end

  describe 'GET #index' do
    it 'should render the #index page' do
      get :index
      response.should render_template :index
    end

    it 'should get the list of all books' do
      books = FactoryGirl.create(:valid_book)
      books.should_not be_nil
      get :index
      assigns(:books).should eq([books])
    end

  end

  describe 'GET #own_books' do
    it 'should render the #own_books page' do
      get :own_books
      response.should render_template :own_books
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'creates a new book' do
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book)
        }.to change(Book, :count).by(1)
      end

      it 'creates a new owner' do
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book)
        }.to change(Owner, :count).by(1)
      end
    end

    it 'redirects to the list own books page with title of last added book' do
      post :create, book: FactoryGirl.attributes_for(:valid_book)
      response.should redirect_to(books_own_books_path),{notice: FactoryGirl.attributes_for(:valid_book)[:title] }
    end

    context 'with invalid attributes' do

      it 'does not creates a new book' do
        expect { post :create, book: FactoryGirl.attributes_for(:invalid_book)
        }.to_not change(Book, :count)
      end
    end

    it 're-renders the new method' do
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

  describe 'GET #edit' do

    it 'should render the edit page' do
      get :edit, id: FactoryGirl.create(:valid_book)
      response.should render_template :edit
    end

  end

  describe 'PUT #update' do

    before(:each) do
      @book = FactoryGirl.create(:valid_book)
    end

    context 'with valid attributes' do

      it 'located the requested @book' do
        put :update, id: @book, book: FactoryGirl.attributes_for(:valid_book)
        assigns(:book).should eq(@book)
      end

      it 'changes the book attributes' do
        put :update, id: @book, book: FactoryGirl.attributes_for(:valid_book, title: 'Harry Potter and The Chamber of secrets')
        @book.reload
        @book.title.should eq('Harry Potter and The Chamber of secrets')
      end

      it 'should redirect to the updated contact' do
        put :update, id: @book, book: FactoryGirl.attributes_for(:valid_book)
        response.should redirect_to @book
      end

    end

    context 'with invalid attributes' do
      it 'located the requested @book' do
        put :update, id: @book, book: FactoryGirl.attributes_for(:invalid_book)
        assigns(:book).should eq(@book)
      end
    end

    it "does not change @contact's attributes" do
      put :update, id: @book,
          book: FactoryGirl.attributes_for(:invalid_book, isbn: nil)
      @book.reload
      @book.title.should eq('Harry Potter and The Prisoner fo Askaban')
    end

    it "re-renders the edit method" do
      put :update, id: @book, book: FactoryGirl.attributes_for(:invalid_book)
      response.should render_template :edit
    end

  end

end
