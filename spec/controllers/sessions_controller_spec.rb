require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    let(:alice) { Fabricate(:user) }
    it "should redirect to root path if already signed in" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end

    it "should render new template if not signed in" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    let(:alice) { Fabricate(:user) }
    context "with valid credentials" do
      before { post :create, params: { email: alice.email, password: alice.password } }

      it "should create a new session" do
        expect(session[:user_id]).not_to be_nil
      end

      it "stores the correct user id in the session" do
        expect(session[:user_id]).to eq(alice.id)
      end

      it "should set a flash success message" do
        expect(flash[:success].blank?).to be false
      end

      it "redirects to the user's profile page" do
        expect(response).to redirect_to user_path(alice)
      end
    end

    context "with invalid credentials" do
      before { post :create, params: { email: alice.email, password: alice.password + "wrong" } }
      it "should not create a new session" do
        expect(session[:user_id]).to be_nil
      end

      it "should render new template" do
        expect(response).to render_template :new
      end

      it "should set the flash error message" do
        expect(flash[:danger].blank?).to be false
      end
    end
  end

  describe "GET destroy" do
    context "with signed in user" do
      before do
        set_current_user
        get :destroy
      end

      it "should clear the user from the session" do
        expect(session[:user_id]).to be_nil
      end

      it "should redirect to the root path" do
        expect(response).to redirect_to root_path
      end

      it "should set the flash notice" do
        expect(flash[:info]).not_to be_blank
      end
    end

    context "with unathenticated user" do
      it_behaves_like "require sign in" do
        let(:action) { get :destroy }
      end
    end
  end
end