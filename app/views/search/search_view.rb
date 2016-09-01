module SearchView

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
