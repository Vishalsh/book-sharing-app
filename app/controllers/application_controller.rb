class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :load_stats_variables, only: [:own_books, :shared_books, :borrowed_books, :show, :index]

  private
  def load_stats_variables
    @own_books = get_own_books_count
    @shared_books = get_shared_books_count
    @borrowed_books = get_borrowed_books_count
  end

  def get_own_books_count
    user = User.where(name: session[:cas_user]).first
    if user
     return user.books.count
    end
    0
  end

  def get_shared_books_count
    owner_id = User.where(name: session[:cas_user]).pluck(:id)
    BookBorrower.where(owner_id: owner_id).count
  end

  def get_borrowed_books_count
    borrower_id = User.where(name: session[:cas_user]).pluck(:id)
    BookBorrower.where(borrower_id: borrower_id).count
  end

end
