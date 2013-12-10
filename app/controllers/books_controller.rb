class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book].permit(:title, :description, :isbn, :edition))

    if @book.save && BookOwner.new(user_id: session[:cas_user], book_id:@book.id).save
      redirect_to book_path(@book)
    else
      render template: 'books/new'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

end
