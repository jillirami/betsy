Rails.application.routes.draw do
  get "reviews/index"
  get "categories/index"
  get "products/index"
  get "orders/index"
  get "order_items/index"
  get "merchants/index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create"
  delete "/logout", to: "users#destroy", as: "logout"

  get "/merchants/current", to: "merchants#current", as: "current_merchant"
end
