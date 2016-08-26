require_relative "../views/sessions/sessions_view"

class SessionsController < ApplicationController
  include SessionsView

  skip_before_action :token_authenticate! 

  def create
    user = User.find_by(email: params.fetch(:user, {})[:email])
    if user && user.authenticate(params[:user][:password])
      render  status: 201, 
        json: login_success(user)
    elsif user
      render status: 400, 
        json: password_error(user)
    else
      render status: 400, 
        json: not_found_error(user)
    end
  end

end
