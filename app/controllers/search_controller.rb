class SearchController < ApplicationController

  def index
    @books = Book.search(params[:search])
    if @books.nil?

    end
  end

end
