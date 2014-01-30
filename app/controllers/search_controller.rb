class SearchController < ApplicationController

  def index

    if params[:filter] == 'tag'
      tag = Tag.filter_by(params[:value])

      if tag.nil?
        @books = []
        return
      end
      @books = tag.books
      return
    end

    @books = Book.filter_by(params[:filter], params[:value])
  end

end
