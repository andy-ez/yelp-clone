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

  describe "GET new" do
    let(:business) { Fabricate(:business) }
    context "with authenticated user" do
      before do
        set_current_user
        get :new, params: { business_id: business.id }
      end

      it "sets business instance variable" do
        expect(assigns(:business)).to be_a(Business)
      end

      it 'sets review instance variable' do
        expect(assigns(:review)).to be_a(Review)
      end
    end

    context "without authenticated user" do
      it_behaves_like "require sign in" do
        let(:action) { get :new, params: { business_id: business.id } }
      end
    end
  end

  describe "POST create" do
    let(:alice) { Fabricate(:user) }
    let(:shop) { Fabricate(:business) }

    context "with authenticated user" do
      context "with valid inputs" do
        before do
          set_current_user(alice)
          post :create, params: { business_id: shop.id, review: { rating: Fabricate.attributes_for(:review)[:rating], body: Fabricate.attributes_for(:review)[:body] } } 
        end

        it "creates a review" do
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the current user" do
          expect(Review.first.user).to eq(alice)
        end

        it "creates a review associated with the business" do
          expect(Review.first.business).to eq(shop)
        end

        it "sets a success flash messsage" do
          expect(flash[:success]).not_to be_blank
        end

        it "redirects to the business show page" do
          expect(response).to redirect_to shop
        end
      end

      context "with invalid inputs" do
        before do
          set_current_user(alice)
          post :create, params: { business_id: shop.id, review: { rating: "", body: "" }  } 
        end

        it "does not create a review" do
          expect(Review.count).to eq(0)
        end

        it "re-renders form" do
          expect(response).to render_template :new
        end

        it "assigns the review and business instance varibales" do
          expect(assigns(:business)).to be_a(Business)
          expect(assigns(:review)).to be_a(Review)
        end

        it "sets a flash error message" do
          expect(flash[:danger]).not_to be_empty
        end
      end

      context "already submitted a review" do
        before do
          alice.reviews << Review.new( business_id: shop.id, rating: (1..5).to_a.sample, body: "Nice Review!")
          set_current_user(alice)
          post :create, params: { business_id: shop.id, review: { rating: "2", body: "Nice review." }  } 
        end

        it "does not create a review" do
          expect(Review.count).to eq(1)
        end

        it "re-renders form" do
          expect(response).to redirect_to shop
        end
      end
    end

    context "without authenticated user" do
      it_behaves_like "require sign in" do
        let(:action) { post :create, params: { business_id: shop.id, review: Fabricate.attributes_for(:review) } } 
      end
    end
  end
end