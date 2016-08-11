class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render status: 201, json: {
        user: {
          email: user.email,
          token: user.token,
          persisted: user.persisted?,
        },
      }
    else
      render status: 400, json: {
        errors: {
          user: user.errors,
        }
      }
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :password, :token)
  end
end
