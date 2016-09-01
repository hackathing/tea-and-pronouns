require_relative "../views/search/search_view"

class SearchController < ApplicationController
  include SearchView

  def create
    search_users = User.search(params[:search_term])
    user_list = search_users.map do |user|
      [name: user.name, id: user.id]
    end
    if user_list == []
      render status: 200,
        json: no_match_found
    else
    render status: 201,
      json: search_results(user_list)
    end
  end

end
