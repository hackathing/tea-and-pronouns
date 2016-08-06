Rails.application.routes.draw do
  post "/users" => "users#create"
end
