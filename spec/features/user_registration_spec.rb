require 'rails_helper'

feature "User registration" do
  scenario "User visits the registration page and signs up with valid credentials" do
    visit root_path
    click_link "Sign Up"
    fill_in "First Name", with: "Test"
    fill_in "Surname", with: "User"
    fill_in "Email", with: "test-user@example.com"
    fill_in "City", with: "Boringwood"
    fill_in "Post Code", with: "BR5 XX0"
    fill_in "Password", with: "password"
    click_button "Register"

    expect(page).to have_content "Log In"
  end

end