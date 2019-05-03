Rails.application.routes.draw do
  root to: "merchants#index"
  resources :products
  resources :merchants

  delete "/logout", to: "merchants#logout", as: "logout"

  get "/merchants/current", to: "merchants#current", as: "current_merchant"
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"

  patch "/products/:id/retired", to: "products#retired", as: "retired_product"
end
