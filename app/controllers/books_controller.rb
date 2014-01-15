class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def own_books
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
    book_matching_isbn = GoogleBooks.search(isbn).first;
    possible_book = Book.new(title: book_matching_isbn.title, description: book_matching_isbn.description,
                             author: book_matching_isbn.authors)
    render json: {possible_book: possible_book, image_link: book_matching_isbn.image_link}, status: :ok

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
    if book.save_or_update_with_owner { session[:cas_user] }
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
