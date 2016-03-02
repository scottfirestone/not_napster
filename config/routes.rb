Rails.application.routes.draw do
  root to: "static_pages#landing"

  resources :albums, only: [:index]
  resources :artists, only: [:index]

  resources :carts, only: [:index, :create, :destroy]

  get "/:genre", to: "genres#show", as: "genre"
end
