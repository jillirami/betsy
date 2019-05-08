Rails.application.routes.draw do
  delete "/logout", to: "merchants#logout", as: "logout"
  root to: "products#index"
  resources :products
  resources :merchants

  # patch "/orders/:id", to: "orders#update", as: "update_order"
  resources :orders
  resources :categories
  resources :order_items

  # resources :merchants do
  # resources :reviews, only: [:new, :create]
  # end

  get "/merchants/current", to: "merchants#current", as: "current_merchant"
  get "/merchants/dashboard/:id", to: "merchants#dashboard", as: "dashboard"
  get "/merchants/dashboard/:id/orders", to: "merchants#orders", as: "dashboard_orders"
  get "/merchants/dashboard/:id/orders/pending", to: "merchants#pending_orders", as: "dashboard_pending_orders"
  get "/merchants/dashboard/:id/orders/paid", to: "merchants#paid_orders", as: "dashboard_paid_orders"
  get "/merchants/dashboard/:id/orders/completed", to: "merchants#completed_orders", as: "dashboard_completed_orders"
  get "/merchants/dashboard/:id/orders/cancelled", to: "merchants#cancelled_orders", as: "dashboard_cancelled_orders"

  get "/merchants/dashboard/:id/products", to: "merchants#products", as: "dashboard_products"
  get "/orders/receipt/:id", to: "orders#receipt", as: "receipt"
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"

  patch "/products/:id/retired", to: "products#retired", as: "retired_product"
end
