Rails.application.routes.draw do
  post "/register" => "registrations#create"
  post "/login" => "sessions#create"
  get "/test" => "tests#show"
  get "/profile" => "profile#show"
  patch "/profile" => "profile#update"
  get "/preferences" => "preferences#show"
  patch "/preferences" => "preferences#update"
  post "/groups" => "groups#create"
  patch "/groups" => "groups#update"
end
