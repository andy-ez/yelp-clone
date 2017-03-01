require 'rails_helper'

describe BusinessesController do
  describe 'GET index' do
    before do
      10.times { Fabricate(:business) }
      get :index
    end

    it "should assign businesses instance variable to paginated version with limit of 10" do
      expect(assigns(:businesses)).to eq(Business.first(10))
    end

    it "should be ordered by created at field in reveerse chronological order" do
      expect(assigns(:businesses)[0]).to eq(Business.order('created_at DESC')[0])
    end
  end

  describe 'GET new' do
    context "with authenticated user" do
      before { set_current_user }
      it "assigns business instance variable" do
        get :new
        expect(assigns(:business)).to be_a(Business)
      end
    end

    context "with unathenticated user" do
      it_behaves_like "require sign in" do
        let(:action) { get :new }
      end
    end
  end

  describe "POST create" do
    context "with authenticated user" do
      before { set_current_user }

      context "with valid inputs" do
        before { post :create, params: { business: Fabricate.attributes_for(:business) } }
        it "should create a new Business" do
          expect(Business.count).to eq(1)
        end

        it "should create a business with all the fields set" do
          expect(Business.first.attributes.values.include?(nil)).to be false
        end

        it "should redirect_to businesses path" do
          expect(response).to redirect_to(businesses_path)
        end

        it "should set a flash message" do
          expect(flash[:success]).to_not be nil
        end
      end

      context "with categories set" do
        let(:category1) { Fabricate(:category) }
        let(:category2) { Fabricate(:category) }

        before do
          attributes = Fabricate.attributes_for(:business).merge( { category_ids: [ category1.id, category2.id ] } )
          post :create, params: { business: attributes }
        end

        it "should create a business associated to the cateogies" do
          expect(Business.first.categories).to match_array([category1, category2])
        end
      end

      context "with invalid input" do
        let(:biz) { Business.new(name: "Invalid Business") }
        before { post :create, params: { business: { name: biz.name } } }
        it "should render new template" do 
          expect(response).to render_template(:new)
        end

        it "should not create a business" do 
          expect(Business.count).to eq(0)
        end

        it "assigns business instance variable" do
          expect(assigns(:business).attributes).to eq(biz.attributes)
        end
      end
    end

    context "with unathenticated user" do
      it_behaves_like "require sign in" do
        let(:action) { post :create, params: Fabricate.attributes_for(:business) }
      end
    end
    
  end
end