require 'rails_helper'

describe Review do
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:body) }
  it { should validate_numericality_of(:rating).is_less_than(6).is_greater_than(0).only_integer }
  it { should validate_uniqueness_of(:business_id).scoped_to(:user_id).with_message("You have already submitted a review for this business") }
end