class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user 
      # && user.authenticate(params[:password])
      # session[:user] = user
      render status: 201, json: {
        user: {
          email: user.email,
          token: user.token,
          persisted: user.persisted?,
        },
      }
    else
      render status: 400
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :password, :token)
  end
end

