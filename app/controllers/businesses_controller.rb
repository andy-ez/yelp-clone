class BusinessesController < ApplicationController
  before_action :require_user, only: [ :new, :create ]
  def index
    @businesses = Business.paginate(page: params[:page], per_page: 10)
  end

  def show
    @business = Business.find(params[:id])
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      flash[:success] = "Business Created"
      redirect_to businesses_path
    else
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :description, :address_first_line, :city, :post_code, :phone_number, :expense, :category_ids => [])
  end
end