Rails.application.routes.draw do
  post "/user", to: "users#create"
end
