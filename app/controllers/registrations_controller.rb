require_relative "../views/registrations/render_json"

class RegistrationsController < ApplicationController
  include RegistrationsJson

  skip_before_action :token_authenticate! 

  def create
    user = User.new(user_params)
    if user.save
      render status: 201, 
        json: registration_success(user)
    else
      render status: 400, 
        json: user_errors(user)
    end
  end

  private

  def user_params
    params.fetch(:user, {})
    .permit(:name, :email, :password)
  end
end
