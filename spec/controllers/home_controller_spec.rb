require 'spec_helper'

describe HomeController do
   

  context 'index' do
    it 'should redirect to new page' do
      get(:index).should redirect_to '/home/new'
    end
  end
end
