Rails.application.routes.draw do
  delete "/logout", to: "merchants#logout", as: "logout"
  root to: "orderitems#index"
  resources :products
  resources :merchants
  resources :orders

  # resources :merchants do
    # resources :reviews, only: [:new, :create]
  # end


  get "/merchants/current", to: "merchants#current", as: "current_merchant"
  get "/merchants/dashboard/:id", to: "merchants#dashboard", as: "dashboard"
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"

  patch "/products/:id/retired", to: "products#retired", as: "retired_product"
end
