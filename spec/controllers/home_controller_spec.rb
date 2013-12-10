require 'spec_helper'

describe HomeController do
   

    it 'should redirect to new page' do
      get(:index).should redirect_to '/home/new'
    end

    it "should be able to log out"
    	
    
end
