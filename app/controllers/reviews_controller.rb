class ReviewsController < ApplicationController
  before_action :require_user, only: [ :new, :create ]
  def index
    @reviews = Review.paginate(page: params[:page], per_page: 25)
  end

  def new

  end

  def create

  end
end