require_relative "../views/search/search_view"

class SearchController < ApplicationController
  include SearchView

  def create
    search_users
    if search_users == []
      render status: 200,
        json: no_match_found
    else
    render status: 201,
      json: search_results(user_list)
    end
  end

  def search_params
    params[:search_term]
  end
end
