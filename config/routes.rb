Rails.application.routes.draw do
  root to: "static_pages#landing"
  resources :albums,  only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end
  resources :artists, only: [:index, :show], param: :artist_name

  resources :users, only: [:new, :create, :update]
  resource :cart

  resources :orders, only: [:new, :show, :create, :index]

  get "/dashboard",      to: "users#show"
  get "/dashboard/edit", to: "users#edit",  as: "user_edit"

  get "/login",     to: "sessions#new"
  post "/login",    to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/:genre",    to: "genres#show",  as: "genre"

  namespace :admin do
    resource  :dashboard, only: [:show]
    resource  :info,      only: [:edit, :update]
    resources :albums,    only: [:index, :new, :create, :edit, :update]
  end
end
