class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book].permit(:title, :description, :isbn, :edition))

    if @book.save && BookOwner.new(user_id: session[:cas_user], book_id:@book.id).save
      redirect_to new_book_path, {notice: @book.title}
    else
      render template: 'books/new'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(params[:book].permit(:title, :description, :isbn, :edition))
      redirect_to @book
    else
      render 'edit'
    end

  end

  def show_user_book
    @books = BookOwner.where(user_id: session[:cas_user])
  end

end
