require_relative "../views/profile/profile_view"

class ProfileController < ApplicationController
  include ProfileView

  def show
    user = @current_user
    render status: 200, 
      json: profile_success(user)
  end

  def update
    user = @current_user
    if user.update(user_params)
      render status: 200, 
        json: profile_success(user)
    else
      render status: 400, 
        json: user_errors(user)
    end
  end

  private

  def user_params
    params.fetch(:profile, {}).permit(:name, :email, :password)
  end

end
