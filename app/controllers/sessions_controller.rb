class SessionsController < ApplicationController
  before_action :require_user, only: [ :destroy ]

  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      create_session(user)
    else
      flash.now[:danger] = "Error - Incorrect Credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "Successfully signed out."
    redirect_to root_path
  end

  private

  def create_session(user)
    session[:user_id] = user.id
    flash[:success] = "Welcome #{user.first_name}!"
    redirect_to user_path(user)
  end
end