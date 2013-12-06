require 'spec_helper'

describe "Navigation bar" do

  before(:all) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  before(:each) do
  	visit 'test/new'
  end

  it "should have message" do
    expect(page).to have_content('What would you like to do?')
  end
  
  it "should have link to search page" do 
  	expect(page).to have_link('Search', href: '#')
  end 
end