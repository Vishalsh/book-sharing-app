require 'spec_helper'

describe 'ApplicationController' do
  
  controller do
    def index
      redirect_to '/hugga/pugga'
    end
  end

  it 'should redirect to CAS if the user is not logged in' do
    CASClient::Frameworks::Rails::Filter.fake(nil)
    get(:index).should redirect_to('https://cas.thoughtworks.com/cas/login?service=http%3A%2F%2Ftest.host%2Fanonymous%2Findex')
    end

  it 'should redirect to hugga/puuga page if the user is logged in' do
    CASClient::Frameworks::Rails::Filter.fake('alladin')
    get(:index).should redirect_to '/hugga/pugga'
  end

end