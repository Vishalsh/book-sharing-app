class HomeController < ApplicationController

  def index
    redirect_to '/home/new'

  end

  def new
    @user = session[:cas_user]
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
