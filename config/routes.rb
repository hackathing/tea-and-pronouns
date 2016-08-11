Rails.application.routes.draw do
  post "/users" => "users#create"
  post "/login" => "sessions#create"
  # delete "/logout" => "sessions#destroy"
end
