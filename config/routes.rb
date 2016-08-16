Rails.application.routes.draw do
  post "/register" => "registration#create"
  post "/login" => "sessions#create"
  get "/test" => "tests#show"
end
