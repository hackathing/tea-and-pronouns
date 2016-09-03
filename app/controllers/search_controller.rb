require_relative "../views/search/search_view"

class SearchController < ApplicationController
  include SearchView

  def create
    search_users = User.search(search_params)
    render status: 200,
      json: search_results(search_users)
  end


  private


  def search_params
    params[:search_term]
  end
end
