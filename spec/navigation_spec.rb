require 'spec_helper'

describe "Navigation bar" do

  before(:all) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  before(:each) do
  	visit 'home/new'
  end

  #TODO : Put these tests in a functional spec




 context "Should have links" do
    it "should have link to search page" do
      expect(page).to have_link('Search Book', href: '/search')
    end

    it "should have link to Manage Your Books page" do
      expect(page).to have_link('Manage Your Books', href: '/books/own_books')
    end

    it "should have link to List All Book page" do
      expect(page).to have_link('List All Books', href: '/books' )
    end

  end


end