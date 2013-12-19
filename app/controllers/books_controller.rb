class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def own_books
    @book = Book.new

    owner = Owner.where(name: session[:cas_user]).first

    if owner
      @books = owner.books.uniq
    else
      @books = []
    end
  end

  def new
    @book = Book.new
    respond_to do |format|
      format.html { render partial: 'form' }
    end
  end

  def create
    @book = Book.new(params[:book].permit(:title, :description, :isbn, :edition, :author))

    if @book.save_or_update_with_owner {session[:cas_user]}
      redirect_to books_own_books_path, {notice: @book.title}
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
end
