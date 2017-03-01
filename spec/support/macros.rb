def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def current_user
  User.find(session[:user_id]) if session[:user_id]
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in(user=nil)
  a_user = user || Fabricate(:user)
  visit login_path
  fill_in "Email Address", with: a_user.email
  fill_in "Password", with: a_user.password
  click_button "Log In"
end