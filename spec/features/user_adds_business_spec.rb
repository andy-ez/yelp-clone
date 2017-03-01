require 'rails_helper'

feature "Adding a Business" do
  scenario "User visits new business page and creates a new business with valid inputs" do
    sign_in
    attributes = Fabricate.attributes_for(:business)
    add_a_business(attributes)
    
    expect(page).to have_content 'Top Businesses'
    expect(page).to have_content attributes[:name]

  end
end