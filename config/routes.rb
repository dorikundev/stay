Rails.application.routes.draw do
  get '/search', to: 'searches#search', as: :search

  root 'rooms#index'
  get 'rooms/index'
  get 'rooms/new'
  get 'rooms/own', to: 'rooms#own', as: :own_rooms
  devise_for :users
  resources :rooms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
