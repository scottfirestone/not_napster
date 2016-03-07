Rails.application.routes.draw do
  root to: "static_pages#landing"

  resources :albums,  only: [:index, :show]
  resources :artists, only: [:index, :show], param: :artist_name

  resources :users, only: [:new, :create]
  resources :carts, only: [:index, :create, :destroy, :update]
  resource :order, only: [:new, :show, :create]

  get "/dashboard", to: "users#show"

  get "/login",     to: "sessions#new"
  post "/login",    to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/cart",      to: "carts#index", as: "user_cart"
  get "/:genre",    to: "genres#show", as: "genre"

  namespace :admin do
    resource :dashboard, only: [:show]
    resource :info,      only: [:edit, :update]
  end
end
