require 'rails_helper'

feature "Adding a Business" do
  scenario "User visits new business page and creates a new business with valid inputs" do
    visit root_path
    click_link "Add Business"

    fill_in "Business Name", with: "My New Business"
    fill_in "Description", with: "Purely setup wfor testing"
    fill_in "Address - First Line", with: "10 Downing Street"
    fill_in "City", with: "Paris"
    fill_in "Post Code", with: "XX1 0XX"
    fill_in "Phone Number", with: "07777000111"
    select "3", from: "Expense Rating"
    click_button 'Create'
    
    expect(page).to have_content 'Top Businesses'
    expect(page).to have_content 'My New Business'

  end
end