class InvitesController < ApplicationController

  def index
    user = @current_user
    render status: 200,
      json: {
      invites: user.group_invites(user)
    }
  end

  def create
    user = @current_user
    group = Group.find_by(name: params.fetch(:name))
    invited_user = User.find_by(name: params.fetch(:name))
    if group && group.users.include?(user)
      render status: 201,
        json: {
        invited: invited_user,
        group: group,
      }
    elsif group
      render status: 403,
        json: {
        errors: {
          group: { user: ["is not a member"] }
        }
      }
    else
    {
      errors: {
        group: ["not found"]
      }
    }
    end
  end

  def update
    user = @current_user
    group = Group.find_by(name: params.fetch(:name))
    group_membership = GroupMembership.find_by(group: group)
    if group && group.users.include?(user) && group_membership.accepted == nil || false
      render status: 200,
        json: invite_accepted(user)
    elsif group && group.users.include?(user)
      render status: 400,
        json: already_member(user)
    elsif group
      render status: 403,
        json: {
        errors: {
          group: { user: ["is not a member"] }
        }
      }
    else
    {
      errors: {
        group: ["not found"]
      }
    }
    end
  end
end
