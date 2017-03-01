require 'rails_helper'

describe ReviewsController do
  describe 'GET index' do
    before do
      10.times { Fabricate(:review) }
      get :index
    end

    it "should assign businesses instance variable to paginated version with limit of 10" do
      expect(assigns(:reviews)).to eq(Review.first(10))
    end

    it "should be ordered by created at field in reveerse chronological order" do
      expect(assigns(:reviews)[0]).to eq(Review.order('created_at DESC')[0])
    end
  end
end