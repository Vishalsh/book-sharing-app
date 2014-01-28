class BorrowersController < ApplicationController

  def new
    @users = User.pluck(:name)
    respond_to do |format|
      format.html { render partial: 'add_borrower_form' }
    end
  end

  def create
    owner_id = User.where(name: session[:cas_user]).pluck(:id).first
    borrower = User.find_or_create_by(name: params[:name])
    borrower_id = borrower.id
    book_borrower = BookBorrower.new(book_id: params[:book_id], owner_id: owner_id, borrower_id: borrower_id, date_of_borrowing: params[:date_of_borrowing])
    if book_borrower.save
      respond_to do |format|
        format.json { render json: book_borrower, status: :created }
      end

    else
      respond_to do |format|
        format.json { render json: book_borrower.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book_borrower = BookBorrower.find(params[:id])
    @book_borrower.destroy
    redirect_to book_path(params[:book_id])
  end

end
