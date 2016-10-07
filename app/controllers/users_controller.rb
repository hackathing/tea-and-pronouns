require_relative "../views/users/users_view.rb"
class UsersController < ApplicationController
  include UsersView

  def index
    users = User.all
    render status: 200,
      json: users_success(users)
  end
end
