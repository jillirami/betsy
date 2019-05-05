Rails.application.routes.draw do
  delete "/logout", to: "merchants#logout", as: "logout"
  root to: "merchants#index"
  resources :products
  resources :merchants

  # patch "/orders/:id", to: "orders#update", as: "update_order"
  resources :orders
  resources :categories

  # resources :merchants do
  # resources :reviews, only: [:new, :create]
  # end

  get "/merchants/current", to: "merchants#current", as: "current_merchant"
  get "/merchants/dashboard/:id", to: "merchants#dashboard", as: "dashboard"
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"

  patch "/products/:id/retired", to: "products#retired", as: "retired_product"
end
