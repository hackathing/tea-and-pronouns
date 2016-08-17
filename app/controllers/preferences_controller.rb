class PreferencesController < ApplicationController

  def show
    user = @current_user
    render status: 200, json: {
        preferences: user.preferences,
        id: user.id
    }
  end

  def update
    user = @current_user
    if user.preferences.merge!(user_params)
      render status: 200, json: {
          preferences: user.preferences,
          id: user.id,
        }
      user.save!
    else
      render status: 400, json: {
        errors: {
          user: user.errors,
        }
      }
    end
  end

    def user_params
      params.fetch(:preferences, {}).permit(:tea, :coffee, :milk, :sugar).to_h
    end
end
