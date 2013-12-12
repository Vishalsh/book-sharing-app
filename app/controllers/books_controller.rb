class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def own_books

  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book].permit(:title, :description, :isbn, :edition, :author))

    if @book.save
      @book.owners.create(name: session[:cas_user])
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
    @books = Owner.where(user_id: session[:cas_user])
  end

end
