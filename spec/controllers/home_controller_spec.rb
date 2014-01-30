require 'spec_helper'

describe HomeController do

  before(:each) do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
  end

  context 'index' do
    it 'should redirect to new page' do
      get(:index).should redirect_to '/home/new'
    end
  end

  context 'logout' do
    it 'should logout from CAS' do
      get(:logout).should redirect_to 'https://cas.thoughtworks.com/cas/logout?service'
    end
  end

end
