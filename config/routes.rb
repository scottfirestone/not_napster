Rails.application.routes.draw do
  resources :albums, only: [:index]

  get "/:genre", to: "genres#show", as: "genre"
end
