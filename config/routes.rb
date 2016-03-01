Rails.application.routes.draw do
  root to: "static_pages#landing"

  resources :albums, only: [:index]

  get "/:genre", to: "genres#show", as: "genre"
end
