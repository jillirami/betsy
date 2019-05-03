Rails.application.routes.draw do
  root to: "merchants#index"
  resources :products
  resources :merchants

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create"
  delete "/logout", to: "users#destroy", as: "logout"

  get "/merchants/current", to: "merchants#current", as: "current_merchant"
end
