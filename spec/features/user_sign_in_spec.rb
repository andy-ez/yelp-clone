require 'rails_helper'

feature "User signs in" do
  scenario "signs in with valid credentials" do
    alice = Fabricate(:user)
    sign_in(alice)
    expect(page).to have_content alice.full_name
  end
end