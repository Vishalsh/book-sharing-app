class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book].permit(:title, :description, :isbn, :edition))

    if @book.save
      redirect_to book_path(@book)
    else
      render template: 'books/new'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

end
