class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def own_books
    user = User.where(name: session[:cas_user]).first
    @copies = []
    if user
      @books, @copies = user.get_books_with_count_of_copies
      render template: 'books/own_books'
    end
  end

  def shared_books
    owner_id = User.where(name: session[:cas_user]).pluck(:id).first
    borrowed_book_ids = BookBorrower.where(owner_id: owner_id).pluck(:book_id)
    @books = Book.where(id: borrowed_book_ids)
    render template: 'books/shared_books'
  end

  def borrowed_books
    borrower_id = User.where(name: session[:cas_user]).pluck(:id).first
    borrowed_book_ids = BookBorrower.where(borrower_id: borrower_id).pluck(:book_id)
    @books = Book.where(id: borrowed_book_ids)
    render template: 'books/borrowed_books'
  end

  def get_by_isbn
    isbn = params[:isbn]
    response_book = GoogleBooks.search(isbn).first;
    if response_book.isbn_10 == isbn
    possible_book = Book.new(title: response_book.title, description: response_book.description,
                             author: response_book.authors)
    end
    render json: {possible_book: possible_book, image_link: response_book.image_link}, status: :ok
  end

  def new
    @book = Book.new
    respond_to do |format|
      format.html { render partial: 'form' }
    end
  end

  def create
    image_url = params[:image_url] + '&printsec=' + params[:printsec] + '&img=' + params[:img] + '&zoom=' + params[:zoom] + '&source=' + params[:source]
    book = Book.new(title: params['book']['title'], author: params['book']['author'], isbn: params['book']['isbn'],
                    edition: params['book']['edition'], description: params['book']['description'], image_url: image_url)
    if book.save_or_update_with_user { session[:cas_user] }
      respond_to do |format|
        format.json { render json: book, status: :created }
      end

    else
      respond_to do |format|
        format.json { render json: book.errors, status: :unprocessable_entity }
      end
    end

  end

  def show
    @book = Book.find(params[:id])
    owner_id = User.where(name: session[:cas_user]).pluck(:id).first
    @book_borrowers = BookBorrower.where(book_id: @book.id, owner_id: owner_id).includes(:borrower)
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
