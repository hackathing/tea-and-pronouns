require_relative "../views/groups/render_json"

class GroupsController < ApplicationController
  include GroupsJson

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
    .permit(:name, :slug, :accepted)
  end
end
