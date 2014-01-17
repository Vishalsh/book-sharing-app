require 'spec_helper'

describe BorrowersController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  describe 'GET #new' do
    it 'should render the #new page' do
      get :new
      response.should render_template 'borrowers/_borrower_info_form'
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do

      before(:each) do
        FactoryGirl.create(:valid_book_user)
      end

      it 'creates a new book borrower' do
        expect { post :create, name: 'abcd', date_of_borrowing: '22/1/2014', book_id: 3, format: :json }
        .to change(BookBorrower, :count).by(1)
      end

      it 'renders the created borrower as json' do
        borrowerWithOutErrors = FactoryGirl.build(:valid_book_borrower)
        post :create, name: 'abcd', date_of_borrowing: '22/1/2014', book_id: 3, format: :json
        response.body.should include (borrowerWithOutErrors.book_id.to_s)
      end

      it 'respond with a 201' do
        post :create,  name: 'abcd', date_of_borrowing: '22/1/2014', book_id: 3, format: :json
        response.status.should eq(201)
      end

    end

    context 'with invalid attributes' do

      before(:each) do
        FactoryGirl.create(:valid_book_user)
      end

      it 'does not creates a new borrower' do
        expect { post :create, name: 'abcd', date_of_borrowing: '22/1/2014', book_id: nil, format: :json
        }.to_not change(Book, :count)
      end

      it 'renders the errors as json' do
        post :create, name: 'abcd', date_of_borrowing: '22/1/2014', book_id: nil, format: :json
        expect(response.body).to eq("{\"book_id\":[\"can't be blank\"]}")
      end

      it 'respond with a 403' do
        post :create, borrower: FactoryGirl.attributes_for(:invalid_book_borrower), format: :json
        response.status.should eq(422)
      end

    end

  end

end

