class BorrowersController < ApplicationController

  def new
    respond_to do |format|
      format.html { render partial: 'borrower_info_form' }
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

  def edit
    @borrower = Borrower.find(params[:id])
    respond_to do |format|
      format.html { render partial: 'borrower_info_form' }
    end
  end

end
