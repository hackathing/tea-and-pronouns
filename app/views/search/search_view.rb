module SearchView

  def user_list
    search_users.map do |user|
      {name: user.name, id: user.id}
    end
  end

    def search_users
    User.search(search_params)
    end


  def search_results(user_list)
    {
      results: user_list
    }
  end

  def no_match_found
    {
      results: "Your search did not match any users"
    }
  end
end
