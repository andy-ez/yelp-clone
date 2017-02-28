require 'rails_helper'

describe Business do 
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :expense }
  it { should validate_presence_of :address_first_line }
  it { should validate_presence_of :city }
  it { should validate_presence_of :post_code }
  it { should validate_presence_of :phone_number }

  it do
    should validate_numericality_of(:expense).
      is_greater_than(0).is_less_than(5).only_integer
  end

  it { should have_many(:reviews).order('created_at DESC') }
  it { should have_many(:categories)  }

  describe "#rating" do
    let(:biz) { Fabricate(:business) }
    it "returns 0 when business has no reviews" do
      expect(biz.rating).to eq(0)
    end

    it "returns the average of all the review ratings to the nearest .5" do
      Fabricate(:review, user: Fabricate(:user), business: biz, rating: 1 )
      Fabricate(:review, user: Fabricate(:user), business: biz, rating: 4 )
      Fabricate(:review, user: Fabricate(:user), business: biz, rating: 3 )

      expect(biz.rating).to eq(2.5)
    end
  end
end