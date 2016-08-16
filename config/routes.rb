Rails.application.routes.draw do
  post "/register" => "registrations#create"
  post "/login" => "sessions#create"
  get "/test" => "tests#show"
  get "/profile" => "profile#show"
  patch "/profile" => "profile#update"
end
