module PreferencesJson

  def preferences_success(user)
    {
      preferences: user.preferences,
      id: user.id
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
