class PreferencesController < ApplicationController

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

  def preferences_success(user)
    {
      preferences: user.preferences,
      id: user.id
    }
  end

  def user_errors(user)
    {
      errors: {
        user: user.errors,
      }
    }
  end
end