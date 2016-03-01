Rails.application.routes.draw do
  resources :albums, only: [:index]
end
