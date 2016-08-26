module SessionsView

  def login_success(user)
    {
      user: {
        id: user.id,
        token: user.token,
        persisted: user.persisted?,
      },
    }
  end

  def password_error(user)
    {
      errors: {
        user: { password: ["is incorrect"] }
      }
    }
  end

  def not_found_error(user)
    {
      errors: {
        user: ["not found"]
      }
    }
  end
end
