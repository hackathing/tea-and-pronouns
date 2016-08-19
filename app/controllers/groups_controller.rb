class GroupsController < ApplicationController

  def create
    user = @current_user
    group = Group.new(name: params.fetch(:group,{})[:name])
    if group.save
      group.add_user(user)
      group.reload
      render status: 201,
        json: create_success(group)
    else
      render status: 404,
        json: group_errors(group)
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
end
