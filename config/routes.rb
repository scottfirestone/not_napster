Rails.application.routes.draw do
  root to: "static_pages#landing"

  resources :albums, only: [:index]
  resources :artists, only: [:index, :show], param: :artist_name

  get "/:genre", to: "genres#show", as: "genre"
end
