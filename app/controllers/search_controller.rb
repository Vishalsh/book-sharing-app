class SearchController < ApplicationController

  def index
    @books = Book.find_by_title(params[:title])
  end

end
