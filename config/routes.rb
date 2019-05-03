Rails.application.routes.draw do
  root to: "merchants#index"
  resources :products
  resources :merchants

  delete "/logout", to: "users#destroy", as: "logout"

  get "/merchants/current", to: "merchants#current", as: "current_merchant"
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
end
