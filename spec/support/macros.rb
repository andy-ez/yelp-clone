def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def current_user
  User.find(session[:user_id]) if session[:user_id]
end

def clear_current_user
  session[:user_id] = nil
end

def add_a_business(attrs)
  click_link "Add Business"

  fill_in "Business Name", with: attrs[:name]
  fill_in "Description", with: attrs[:description]
  fill_in "Address - First Line", with: attrs[:address_first_line]
  fill_in "City", with: attrs[:city]
  fill_in "Post Code", with: attrs[:post_code]
  fill_in "Phone Number", with: attrs[:phone_number]
  select attrs[:expense], from: "Expense Rating"
  click_button 'Create'
end

def sign_in(user=nil)
  a_user = user || Fabricate(:user)
  visit login_path
  fill_in "Email Address", with: a_user.email
  fill_in "Password", with: a_user.password
  click_button "Log In"
end