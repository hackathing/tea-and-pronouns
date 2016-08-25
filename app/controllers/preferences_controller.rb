require_relative "../views/preferences/render_json"
class PreferencesController < ApplicationController
  include PreferencesJson

  def show
    user = @current_user
    render status: 200, 
      json: preferences_success(user)
  end

  def update
    user = @current_user
    if user.preferences.merge!(user_params)
      render status: 200, 
        json: preferences_success(user)
      user.save!
    else
      render status: 400, 
        json: user_errors(user)
    end
  end

  def user_params
    params.fetch(:preferences, {})
    .permit(:tea, :coffee, :milk, :sugar)
    .to_h
  end
end
