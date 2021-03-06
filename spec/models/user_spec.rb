require 'rails_helper'

describe User do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :city }
  it { should validate_presence_of :post_code }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should_not allow_value('invalidEmail.com').for('email') }
  it { should have_many(:reviews).order('created_at DESC') }

  describe "#before_save_downcase_email" do
    it "should save the lowercase version of any input email in the database for the user" do
      Fabricate(:user, email: "MYeMail@example.com")
      expect(User.first.email).to eq("myemail@example.com")
    end
  end
end