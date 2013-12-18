class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def own_books
    owner = Owner.where(name: session[:cas_user])
    if owner
      @books = owner.map { |e| e.books }.inject([]) { |res, cur| res + cur }
    else
      @books = []
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book].permit(:title, :description, :isbn, :edition, :author))
    @book.current_owner = session[:cas_user]

    if @book.save
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
    @book.current_owner = session[:cas_user]

    if @book.update(params[:book].permit(:title, :description, :isbn, :edition))
      redirect_to @book
    else
      render 'edit'
    end
  end
end
