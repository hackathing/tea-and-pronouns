class RegistrationsController < ApplicationController
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
    .permit(:email, :password)
  end

  def registration_success(user)
    {
      user: {
        email: user.email,
        token: user.token,
        persisted: user.persisted?,
      },
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
