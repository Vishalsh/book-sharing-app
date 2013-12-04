require 'spec_helper'

describe TestController do
   before(:all) do
     CASClient::Frameworks::Rails::Filter.fake('alladin')
   end

  context 'index' do
    it 'should redirect to new page' do
      get(:index).should redirect_to '/test/new'
    end
  end
end
