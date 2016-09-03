module SearchView

  def search_results(search_users)
    {
      users: search_users.map do |user|
        { name: user.name, id: user.id }
      end
    }
  end
end
