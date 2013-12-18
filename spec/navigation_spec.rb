require 'spec_helper'

describe "Navigation bar" do

  before(:all) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  before(:each) do
  	visit 'home/new'
  end

  #TODO : Put these tests in a functional spec

  #it "should have message" do
  #  expect(page).to have_content('What would you like to do?')
  #end

  context 'Should have links' do
    xit 'should have link to add new book' do
      expect(page).to have_link('+ Add New Book', href: '')
    end

    xit 'should have link to Manage Your Books page' do
      expect(page).to have_link('All Books', href: '/books/own_books')
    end

    #it "should have link to List All Book page" do
    #  expect(page).to have_link('List All Books', href: '/books' )
    #end

  end


end