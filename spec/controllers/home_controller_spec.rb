require 'spec_helper'

describe HomeController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

    it 'should redirect to new page' do
      get(:index).should redirect_to '/home/new'
    end

    it "should be able to log out"
    	
    
end
