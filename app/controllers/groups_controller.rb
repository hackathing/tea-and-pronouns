class GroupsController < ApplicationController

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
    .permit(:name)
  end

  def create_success(group)
    {
      group: {
        name: group.name,
        slug: group.slug,
        members: group.users.pluck(:name),
      }
    }
  end

  def group_errors(group)
    {
      errors: {
        group: group.errors,
      }
    }
  end

  def user_list(group)
    {
      group: {
        name: group.name,
        members: group.users.pluck(:name, :preferences),
      }
    }
  end

  def membership_error(group)
    {
      errors: {
        group: { user: ["is not a member"] }
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
