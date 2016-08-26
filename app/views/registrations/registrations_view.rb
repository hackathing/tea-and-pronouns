module RegistrationsView

  def registration_success(user)
    {
        user: {
          name: user.name,
          email: user.email,
          id: user.id,
          token: user.token,
          persisted: user.persisted?,
      },
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
