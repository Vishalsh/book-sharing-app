class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def own_books
    @book = Book.new #TODO: Modal thingy
    owner = Owner.where(name: session[:cas_user]).first
    @copies = []
   if owner
      @books, @copies = owner.get_books_with_count_of_copies
      render template: 'books/own_books'
   else
      @books = []
    end
  end

  def get_by_isbn
    isbn = params[:isbn]
    book_matching_isbn = GoogleBooks.search('isbn' + isbn).first;
    @possible_book = Book.new
    @possible_book.title = book_matching_isbn.title
    @possible_book.description = book_matching_isbn.description
    @possible_book.isbn = book_matching_isbn.isbn
    # @possible_book.edition = book_matching_isbn.edition
    @possible_book.author = book_matching_isbn.authors 
    binding.pry
    render nothing: true
    respond_to do |format|
      format.json { render json: @possible_book, status: :OK}
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
