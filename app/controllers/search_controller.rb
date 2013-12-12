class SearchController < ApplicationController

  def index
    @books = Book.find_by_title(params[:search])
  end

end