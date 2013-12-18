class SearchController < ApplicationController

  def index
    @book =Book.new
    @books = Book.find_by_title(params[:title])
  end

end
