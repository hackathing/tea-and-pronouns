module UsersView

  def users_success(users)
    {
      users: users.map do |user|
        { name: user.name, id: user.id, gravatar: user.gravatar_for(user) }
      end
    }
  end
end
