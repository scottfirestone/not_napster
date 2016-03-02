Rails.application.routes.draw do
  root to: "static_pages#landing"

  resources :albums, only: [:index]
  resources :artists, only: [:index, :show], param: :artist_name
  resources :users, only: [:new, :create]
  get "/dashboard", to: "users#show", as: "dashboard"

  resources :carts, only: [:index, :create]

  get "/:genre", to: "genres#show", as: "genre"
end
