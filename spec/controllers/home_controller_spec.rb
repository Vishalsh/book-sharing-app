require 'spec_helper'

describe HomeController do

  before(:each) do
    CASClient::Frameworks::Rails
  end
  context 'index' do
    it 'should redirect to new page' do
      get(:index).should redirect_to '/home/new'
    end
  end
end
