require 'spec_helper'

describe "Navigation bar" do

  before(:all) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  before(:each) do
  	visit 'home/new'
  end

  it "should have a greeting message" do
    expect(page).to have_content('What would you like to do?')
  end
  
  it "should have link to search page" do 
  	expect(page).to have_link('Search', href: '#')
  end

  it "should have link to logout" do 
    expect(page).to have_link('Logout', href: "/home/logout")
  end

end