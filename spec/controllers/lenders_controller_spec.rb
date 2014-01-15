require 'spec_helper'

describe LendersController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  describe 'GET #new' do
    it 'should render the #new page' do
      get :new
      response.should render_template 'lenders/_lender_info_form'
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do

      it 'creates a new lender' do
        expect { post :create, lender: FactoryGirl.attributes_for(:valid_lender), format: :json }
        .to change(Lender, :count).by(1)
      end

      it 'renders the created lender as json' do
        lenderWithOutErrors = FactoryGirl.build(:valid_lender)
        post :create, lender: lenderWithOutErrors, format: :json
        response.body.should include (lenderWithOutErrors.name)
      end

      it 'respond with a 201' do
        post :create, lender: FactoryGirl.attributes_for(:valid_lender), format: :json
        response.status.should eq(201)
      end

    end

    context 'with invalid attributes' do
      it 'does not creates a new lender' do
        expect { post :create, lender: FactoryGirl.attributes_for(:invalid_lender), format: :json
        }.to_not change(Book, :count)
      end

      it 'renders the errors as json' do
        post :create, lender: FactoryGirl.attributes_for(:invalid_lender), format: :json
        expect(response.body).to eq("{\"name\":[\"can't be blank\"]}")
      end

      it 'respond with a 403' do
        post :create, lender: FactoryGirl.attributes_for(:invalid_lender), format: :json
        response.status.should eq(422)
      end

    end

  end

end

