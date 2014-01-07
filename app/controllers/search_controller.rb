class SearchController < ApplicationController

  def index
    @books = Book.filter_by(params[:filter], params[:title])
  end

end
