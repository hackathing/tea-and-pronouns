module ProfileView

  def profile_success(user)
    {
      profile: {
        name: user.name,
        email: user.email,
        id: user.id,
        persisted: user.persisted?,
        avatar: user.gravatar_for(user),
        groups: user.groups.pluck(:name), 
      }
    }
  end

  def user_errors(user)
    {
      errors: {
        user: user.errors,
      }
    }
  end
end
