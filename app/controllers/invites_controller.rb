class InvitesController < ApplicationController

  def index
    user = @current_user
    render status: 200,
      json: {
      invites: [user.group_invites(user)]
    }
  end

end
