Rails.application.routes.draw do
  root to: "products#index"

  # patch "/orders/:id", to: "orders#update", as: "update_order"

  delete "/logout", to: "merchants#logout", as: "logout"
  resources :products, except: [:destroy]

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  resources :merchants, only: [:index, :show, :create]

  resources :orders, only: [:show, :edit, :update]
  resources :categories, only: [:index, :show, :new, :create]
  resources :order_items, only: [:create, :edit, :update, :destroy]

  post "/order_items/random", to: "order_items#random_create", as: "random"

  get "/merchants/current", to: "merchants#current", as: "current_merchant"
  get "/merchants/dashboard/:id", to: "merchants#dashboard", as: "dashboard"
  get "/merchants/dashboard/:id/orders", to: "merchants#orders", as: "dashboard_orders"
  get "/merchants/dashboard/:id/orders/pending", to: "merchants#pending_orders", as: "dashboard_pending_orders"
  get "/merchants/dashboard/:id/orders/paid", to: "merchants#paid_orders", as: "dashboard_paid_orders"
  get "/merchants/dashboard/:id/orders/completed", to: "merchants#completed_orders", as: "dashboard_completed_orders"
  get "/merchants/dashboard/:id/orders/cancelled", to: "merchants#cancelled_orders", as: "dashboard_cancelled_orders"

  get "/merchants/dashboard/:id/products", to: "merchants#products", as: "dashboard_products"
  get "/merchants/dashboard/:id/products/retired", to: "merchants#retired_products", as: "dashboard_retired_products"
  get "/merchants/dashboard/:id/products/active", to: "merchants#active_products", as: "dashboard_active_products"

  get "/orders/receipt/:id", to: "orders#receipt", as: "receipt"
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"

  patch "/products/:id/retired", to: "products#retired", as: "retired_product"
  patch "/orders/:id/cancel", to: "orders#cancel", as: "cancel_order"

  patch "/orderitem/:id/shipment", to: "order_items#shipment", as: "shipment"
end
