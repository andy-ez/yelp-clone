require 'rails_helper'

describe BusinessesController do
  describe 'GET index' do
    before { 10.times { Fabricate(:business) } }
    it "should assign businesses instance variable" do
      get :index
      expect(assigns(:businesses)).to eq(Business.all)
    end
  end
end