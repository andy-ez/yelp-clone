class ReviewsController < ApplicationController
  before_action :require_user, only: [ :new, :create ]
  def index
    @reviews = Review.order('created_at DESC').paginate(page: params[:page], per_page: 25)
  end

  def new
    @business = Business.find(params[:business_id])
    @review = Review.new
  end

  def create
    @business = Business.find(params[:business_id])
    unless current_user.can_write_review?(@business)
      flash[:error] = "You have already submitted a review for this business"
      redirect_to @business
    else
      create_the_review
    end
  end

  private

  def create_the_review
    @review = @business.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      flash[:success] = "Successfully added the review"
      redirect_to @business
    else
      flash[:danger] = "An error occured"
      render :new
    end
  end
  
  def review_params
    params.require(:review).permit(:rating, :body)
  end
end