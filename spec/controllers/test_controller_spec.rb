require 'spec_helper'

describe TestController do

  context 'index' do
    it 'should redirect to create' do
      get(:index).should redirect_to '/test/new'
    end
  end

end
