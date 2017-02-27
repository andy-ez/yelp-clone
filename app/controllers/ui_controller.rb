class UiController < ApplicationController
  before_action do
    redirect_to root_path if Rails.env.production?
  end

end

