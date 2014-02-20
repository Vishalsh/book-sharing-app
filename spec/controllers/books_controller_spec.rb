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
                      image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic',
                      format: :json
        }.to change(Book, :count).by(1)
      end

      it 'should create a new book if book data is entered manually with default image' do
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book),
                      image_url: '/assets/book_image.png', tags: 'Harry Potter, epic', format: :json
        }.to change(Book, :count).by(1)
      end

      it 'creates a new user if the user does not exist' do
        User.where("name like 'alladin'").should be_empty
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book),
                      image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic',
                      format: :json
        }.to change(User, :count).by(1)
        User.where("name like 'alladin'").should_not be_empty
      end

      it 'does not create a new user if the user already exists' do
        aBook = FactoryGirl.create(:valid_book)
        aBook.owners.find_or_create_by(name: 'alladin')
        expect { post :create, book: FactoryGirl.attributes_for(:valid_book),
                      image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic',
                      format: :json
        }.not_to change(User, :count)
      end

      it 'renders the created book as json' do
        bookWithOutErrors = FactoryGirl.build(:valid_book)
        post :create, book: bookWithOutErrors,
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic',
             format: :json

        response.body.should include (bookWithOutErrors.author)
      end

      it 'respond with a 201' do
        post :create, book: FactoryGirl.attributes_for(:valid_book),
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic',
             format: :json
        response.status.should eq(201)
      end
    end

    context 'with invalid attributes' do
      it 'does not creates a new book' do
        expect { post :create, book: FactoryGirl.attributes_for(:invalid_book),
                      image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic',
                      format: :json
        }.to_not change(Book, :count)
      end

      it 'renders the errors as json' do
        post :create, book: FactoryGirl.attributes_for(:invalid_book),
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic',
             format: :json
        expect(response.body).to eq("{\"title\":[\"can't be blank\"]}")
      end

      it 'respond with a 403' do
        post :create, book: FactoryGirl.attributes_for(:invalid_book),
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', tags: 'Harry Potter, epic',
             format: :json
        response.status.should eq(422)
      end

      it 'renders the error for tag if it is blank' do
        post :create, book: FactoryGirl.attributes_for(:valid_book),
             image_url: 'abcd?', printsec: 'defg', img: '1', zoom: '1', source: 'gbapi', search_from_api: 'on', tags: '',
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

  end


end
