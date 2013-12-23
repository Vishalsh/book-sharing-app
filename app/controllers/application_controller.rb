class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :load_stats_variables

  private
  def load_stats_variables
    @number = 0
  end


end
