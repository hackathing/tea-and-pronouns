Rails.application.routes.draw do
  post "/users" => "users#create"
  post "/login" => "sessions#create"
  get "/test" => "tests#show"
end
