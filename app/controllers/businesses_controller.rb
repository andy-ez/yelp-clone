class BusinessesController < ApplicationController
  def index
    @businesses = Business.paginate(page: params[:page], per_page: 10)
  end
end