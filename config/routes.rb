Rails.application.routes.draw do
  root to: "static_pages#landing"

  resources :albums, only: [:index]
  resources :artists, only: [:index, :show], param: :artist_name
  
  resources :users, only: [:new, :create]
  resources :carts, only: [:index, :create, :destroy, :update]

  get "/cart", to: "carts#index", as: "user_cart"
  get "/dashboard", to: "users#show"
  get "/:genre", to: "genres#show", as: "genre"

  delete "/logout", to: "sessions#destroy"
end
