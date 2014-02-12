require 'spec_helper'

describe BooksController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  describe 'GET #new' do
    it 'should render the #new page' do
      get :new
      response.should render_template 'books/_form'
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

    it 'should list all the books of the logged in users' do
      book = FactoryGirl.create(:valid_book)
      book.owners << FactoryGirl.build(:valid_book_user)
      get :own_books
      assigns(:books).should eq([book])
    end

  end

  describe 'GET #shared books' do
    it 'should get all the shared books by the logged in user' do
      FactoryGirl.create(:valid_book_user)
      FactoryGirl.create(:valid_book_borrower)
      book = FactoryGirl.create(:valid_book)
      get :shared_books
      assigns(:books).should include(book)
    end

    it 'should not get the books that are not shared by the logged in user' do
      FactoryGirl.create(:valid_book_user)
      FactoryGirl.create(:valid_book_borrower)
      first_book = FactoryGirl.build(:valid_book)
      second_book = FactoryGirl.build(:another_valid_book)
      get :shared_books
      assigns(:books).should_not include(second_book)
    end

    it 'should render the #shared_books page' do
      get :shared_books
      response.should render_template :shared_books
    end
  end

  describe "GET #borrowed books" do

    it 'should get all the borrowed books by the logged in users' do
      FactoryGirl.create(:valid_book_user)
      FactoryGirl.create(:valid_book_borrower)
      book = FactoryGirl.create(:valid_book)
      get :borrowed_books
      assigns(:books).should include(book)
    end

    it 'should render the #borrowed_books page' do
      get :borrowed_books
      response.should render_template :borrowed_books
    end

  end

  describe 'GET #get_by_isbn' do

    context 'with valid isbn' do
      before(:each) do
        @possible_book = OpenStruct.new title: "Harry Potter and The Prisoner of Azkaban",
                                        description: "Harry Potter Epic", authors: "JK Rowling", isbn_10: '1234567890'
        GoogleBooks.should_receive(:search).with('1234567890').and_return([@possible_book])
        get :get_by_isbn, isbn: '1234567890', format: :json
      end

      it 'should render the matching book as json' do
        expect(response.body).to include (@possible_book.title)
        expect(response.body).to include (@possible_book.description)
        expect(response.body).to include (@possible_book.authors)
      end

      it 'should respond with 200' do
        response.status.should eq(200)
      end
    end

    it 'should render the error text if the isbn is not valid' do
      @possible_book = OpenStruct.new title: "Harry Potter and The Prisoner of Azkaban",
                                      description: "Harry Potter Epic", authors: "JK Rowling", isbn_10: '1234567890'
      GoogleBooks.should_receive(:search).with('1234').and_return([@possible_book])
      get :get_by_isbn, isbn: '1234', format: :json
      response.body.should include 'Not a valid Isbn'
    end

  end

  describe 'GET #get_by_title' do

    before(:each) do
      @possible_book = OpenStruct.new title: "Harry Potter and The Prisoner of Azkaban",
                                      description: "Harry Potter Epic", authors: "JK Rowling"
      GoogleBooks.should_receive(:search).with('Harry').and_return([@possible_book])
      get :get_by_title, title: 'Harry', format: :json
    end

    it 'should render the matching book as json' do
      expect(response.body).to include (@possible_book.title)
      expect(response.body).to include (@possible_book.description)
      expect(response.body).to include (@possible_book.authors)
    end

    it 'should respond with 200' do
      response.status.should eq(200)
    end

  end

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'creates a new book with image available from google books when book is searched from google api' do
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book),
                      image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic', search_by_title: 'on',
                      format: :json
        }.to change(Book, :count).by(1)
      end

      it 'should create a new book if book data is entered manually with no Image available image' do
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book),
                      image_url: 'no_img_found.png', tags: 'Harry Potter, epic', format: :json
        }.to change(Book, :count).by(1)
      end

      it 'creates a new user if the user does not exist' do
        User.where("name like 'alladin'").should be_empty
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book),
                      image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic', search_by_title: 'on',
                      format: :json
        }.to change(User, :count).by(1)
        User.where("name like 'alladin'").should_not be_empty
      end

      it 'does not create a new user if the user already exists' do
        aBook = FactoryGirl.create(:valid_book)
        aBook.owners.find_or_create_by(name: 'alladin')
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book),
                      image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic', search_by_title: 'on',
                      format: :json
        }.not_to change(User, :count)
      end

      it 'renders the created book as json' do
        bookWithOutErrors = FactoryGirl.build(:valid_book)
        post :create, book: bookWithOutErrors,
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic', search_by_title: 'on',
             format: :json

        response.body.should include (bookWithOutErrors.author)
      end

      it 'respond with a 201' do
        post :create, book: FactoryGirl.attributes_for(:valid_book),
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic', search_by_title: 'on',
             format: :json
        response.status.should eq(201)
      end
    end

    context 'with invalid attributes' do
      it 'does not creates a new book' do
        expect { post :create, book: FactoryGirl.attributes_for(:invalid_book),
                      image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic', search_by_title: 'on',
                      format: :json
        }.to_not change(Book, :count)
      end

      it 'renders the errors as json' do
        post :create, book: FactoryGirl.attributes_for(:invalid_book),
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic', search_by_title: 'on',
             format: :json
        expect(response.body).to eq("{\"title\":[\"can't be blank\"]}")
      end

      it 'respond with a 403' do
        post :create, book: FactoryGirl.attributes_for(:invalid_book),
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic', search_by_title: 'on',
             format: :json
        response.status.should eq(422)
      end

      it 'renders the error for tag if it is blank' do
        post :create, book: FactoryGirl.attributes_for(:valid_book),
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', search_by_title: 'on', tags: '',
             format: :json
        expect(response.body).to eq("{\"tags\":[\"can't be blank\"]}")
      end

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

    it 'should fetch the borrowers of the book related to the logged in user' do
      FactoryGirl.create(:valid_book_user)
      book_borrower = FactoryGirl.create(:valid_book_borrower)
      get :show, id: @book
      assigns(:book_borrowers).should include(book_borrower)
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
      @book.title.should eq('Harry Potter and The Prisoner fo Azkaban')
    end

    it "re-renders the edit method" do
      put :update, id: @book, book: FactoryGirl.attributes_for(:invalid_book)
      response.should render_template :edit
    end

  end

  describe 'DELETE #destroy' do

    before(:each) do
      @book = FactoryGirl.create(:valid_book)
      @book.owners << FactoryGirl.build(:valid_book_user)
    end

    it 'should delete the book for the logged in user' do
      expect { delete :destroy, id: @book.id }.to change(@book.owners, :count).by (-1)
    end

    it 'should redirect to the book page' do
      delete :destroy, id: @book.id
      response.should redirect_to books_own_books_path
    end

    it 'should delete the borrowers of that book' do

    end

  end


end
