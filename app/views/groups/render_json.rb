module GroupsJson

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
