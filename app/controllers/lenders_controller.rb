class LendersController < ApplicationController

  def new
    @lender = Lender.new
    respond_to do |format|
      format.html { render partial: 'lender_info_form' }
    end
  end

  def create
    lender = Lender.new(name: params['lender']['name'], date_of_lending: params['lender']['date_of_lending'])

    if lender.save
      respond_to do |format|
        format.json { render json: lender, status: :created }
      end

    else
      respond_to do |format|
        format.json { render json: lender.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @lender = Lender.find(params[:id])
    respond_to do |format|
      format.html { render partial: 'lender_info_form' }
    end
  end

  def update_lender
    #@lender = Lender.new(name: params[:name], date_of_lending: params[:date_of_lending])
    if Lender.find_or_create_by(name: params[:name], date_of_lending: params[:date_of_lending])

    end
    redirect_to 'books_own_books_path'
  end

end
