class InvitesController < ApplicationController

  def index
    user = @current_user
    render status: 200,
      json: groups_invited_to(user)
  end

  # POST request for inviting another user to a group.
  def create
    user = @current_user
    group = Group.find_by(name: params.fetch(:group, {})[:name])
    invited_user_name = params.fetch(:user, {})[:name]
    # user names are not unique - how to handle this?
    invited_user = User.find_by(name: invited_user_name)
    if group && group.users.include?(user) && invited_user
      group.add_user(invited_user, accepted: false)
      render status: 201,
        json: invited_success(invited_user, group)
    elsif group && group.users.include?(user)
      render status: 404,
        json: invited_error(invited_user_name)
    elsif group
      render status: 403,
        json: membership_error(user)
    else
      render status: 404,
        json: group_not_found_error
    end
  end

  # Patch request for accepting invites
  def update
    group_membership = GroupMembership.find_by(id: params[:id], user: @current_user)
    if group_membership.present?
      group_membership.update!(update_params)
      render status: 200, json: invite_updated(group_membership)

    else
      render status: 404, json: invite_not_found_error
    end
  end

  private

  def groups_invited_to(user)
    {
      invites: user.group_invites(user)
    }
  end

  def invited_success(invited_user, group)
    {
      invited: invited_user.name,
      group: group.name
    }
  end

  def invited_error(invited_user_name)
    {
      errors: {
        invited: { user: ["does not exist"] }
      }
    }
  end

  def  membership_error(user)
    {
      errors: {
        group: { user: ["is not a member"] }
      }
    }
  end

  def invite_updated(membership)
    {
      invite: {
        id: membership.id,
        accepted: membership.accepted?,
        group: {
          id: membership.group.id,
          name: membership.group.name,
        }
      }
    }
  end

  def group_not_found_error
    {
      errors: {
        group: ["not found"]
      }
    }
  end

  def invite_not_found_error
    {
      errors: {
        invite: ["not found"]
      }
    }
  end

  def update_params
    params.require(:invite).permit(:accepted)
  end
end
