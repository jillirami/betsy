Rails.application.routes.draw do
  root to: "products#index"
  delete "/logout", to: "merchants#logout", as: "logout"
  resources :products, except: [:destroy]
  resources :merchants, only: [:index, :show, :create]

  resources :orders, only: [:show, :edit, :update]
  resources :categories, only: [:index, :show, :new, :create]
  resources :order_items, only: [:create, :edit, :update, :destroy]

  get "/merchants/current", to: "merchants#current", as: "current_merchant"
  get "/merchants/dashboard/:id", to: "merchants#dashboard", as: "dashboard"
  get "/orders/receipt/:id", to: "orders#receipt", as: "receipt"
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"

  patch "/products/:id/retired", to: "products#retired", as: "retired_product"
  patch "/orders/:id/cancel", to: "orders#cancel", as: "cancel_order"
end
