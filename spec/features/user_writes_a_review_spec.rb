require 'rails_helper'

feature "User interacts with business list and writes a review" do
  scenario "user creates a new business and adds a review to it" do
    alice = Fabricate(:user)
    shop_attributes = Fabricate.attributes_for(:business)
    sign_in(alice)
    add_a_business(shop_attributes)

    click_link "Write A Review"
    choose "review_rating_4"
    fill_in "review_body", with: "This is a good review"
    click_button "Submit Review"
    expect(page).to have_content(alice.full_name)
    expect(page).to have_content("This is a good review")
    expect(page).to have_css("div.stars-show-40")

    #user can see teh review on their profile page
    click_link "My Profile"
    expect(page).to have_content("This is a good review")
    expect(page).to have_css("div.stars-show-40")
  end
end