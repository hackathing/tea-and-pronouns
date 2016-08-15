class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params.fetch(:user, {})[:email])
    if user && user.authenticate(params[:user][:password])
      render status: 201, json: {
        user: {
          email: user.email,
          token: user.token,
          persisted: user.persisted?,
        },
      }
    elsif user
      render status: 400, json: {
        errors: {
          user: { password: ["is incorrect"] }
        }
      }
    else
      render status: 400, json: {
        errors: {
          user: ["not found"]
        }
      }
    end
  end
end
