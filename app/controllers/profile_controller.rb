class ProfileController < ApplicationController

  def show
    user = @current_user
    render status: 200, json: {
      user: {
        name: user.name,
        email: user.email,
        id: user.id,
      }
    }
  end

  def update
    user = @current_user
    if user.update(user_params)
      render status: 200, json: {
        profile: {
          name: user.name,
          id: user.id,
          email: user.email,
          persisted: user.persisted?,
        }
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
    params.fetch(:profile, {}).permit(:name, :email, :password)
  end

end
