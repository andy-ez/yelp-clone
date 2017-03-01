require 'rails_helper'

describe UsersController do
  describe 'GET new' do
    it "should set a new user instance variable" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
  end

  describe 'GET show' do
    let(:alice) { Fabricate(:user) }
    it "should set the user instance variable" do
      get :show, params: { id: alice.id }
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      let(:attrs) { Fabricate.attributes_for(:user) }
      before { post :create, params: { user: attrs } }

      it "should create a new user" do
        expect(User.count).to eq(1)
      end

      it "should create a new user with the correct attributes" do
        expect(User.first.first_name).to eq(attrs[:first_name])
      end

      it "sets a flash success message" do
        expect(flash[:success]).not_to be_empty
      end

      it "redirects to the new user's profile page" do
        expect(response).to redirect_to user_path(User.first)
      end
    end

    context "with invalid inputs" do
      before { post :create, params: { user: { first_name: "Invaliduser"} } }
      it "renders the form again" do
        expect(response).to render_template 'users/new'
      end
    end
  end
end