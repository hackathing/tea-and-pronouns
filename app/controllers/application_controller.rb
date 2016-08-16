class ApplicationController < ActionController::API
  before_action :token_authenticate!

  def token_authenticate! 
    token = request.headers["HTTP_AUTHORIZATION"]
    @current_user = User.find_by(token: token) if token.present?
    if @current_user.nil?
      render status: 401, json: {
        error: "valid authorization token required"
      }
    end
  end

end
