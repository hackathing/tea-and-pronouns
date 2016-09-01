require_relative "../views/invites/invites_view"

class InvitesController < ApplicationController
  include InvitesView

  def index
    user = @current_user
    render status: 200,
      json: groups_invited_to(user)
  end

  # POST request for inviting another user to a group.
  def create
    user = @current_user
    group = Group.find_by(id: params.fetch(:invite, {})[:group_id])
    invited_user = User.find_by(id: params.fetch(:invite, {})[:user_id])
    if group && group.users.include?(user) && invited_user
      group.add_user(invited_user, accepted: false)
      render status: 201,
        json: invited_success(invited_user, group)
    elsif group && group.users.include?(user)
      render status: 404,
        json: invited_error
    elsif group
      render status: 403,
        json: membership_error
    else
      render status: 404,
        json: group_not_found_error
    end
  end

  # Patch request for accepting invites
  # Requires params to include {invite: {id: group_membership.id, accepted: true}}
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

  def update_params
    params.require(:invite).permit(:accepted)
  end
end
