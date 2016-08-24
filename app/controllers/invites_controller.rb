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
        json: not_found_error(group)
    end
  end

  ######################tests required ####################
  # Patch request for accepting invites
  def update
    user = @current_user
    group = Group.find_by(name: params.fetch(:name))
    group_membership = GroupMembership.find_by(group: group)
    if group && group.users.include?(user) && group_membership.accepted == nil || false
      group.group_memberships.update(accepted: true)
      render status: 200,
        json: invite_accept(user)
    elsif group && group.users.include?(user)
      render status: 400,
        json: already_member_error(invited_user_name)
    elsif group
      render status: 403,
        json: not_invited_error(user)
    else
      render status: 404,
        json: not_found_error(group)
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

  def invite_accept(user)
    {
      user: user.name,
      group: group.name
    }
  end

  def already_member_error(user)
    {
      errors: {
        invited: {user: ["is already a member"] }
      }
    }
  end

  def not_invited_error(user)
    {
      errors: {
        group: { user: ["not invited to group"] }
      }
    }
  end

  def not_found_error(group)
    {
      errors: {
        group: ["not found"]
      }
    }
  end

end
