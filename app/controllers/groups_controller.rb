require_relative "../views/groups/groups_view"

class GroupsController < ApplicationController
  include GroupsView

  def create
    user = @current_user
    group = Group.new(name: params.fetch(:group, {})[:name])
    if group.save
      group.add_user(user, accepted: true)
      render status: 201,
        json: create_success(group)
    else
      render status: 404,
        json: group_errors(group)
    end
  end

  # shows all members of particular group to user by :slug
  def show
    user = @current_user
    group = Group.find_by(slug: params.fetch(:slug))
    if group && group.users.include?(user)
      render status: 200,
        json: user_list(group)
    elsif group
      render status: 403,
        json: membership_error(group)
    else
      render status: 404,
        json: not_found_error(group)
    end
  end

  private

  def group_params
    params.fetch(:group, {})
    .permit(:id, :name, :slug, :accepted)
  end
end
