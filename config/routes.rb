Rails.application.routes.draw do
  scope :users do
    get 'users/profile', to: 'users#profile'
    get 'users/profile/edit', to: 'users#edit_profile'
    patch 'users/profile', to: 'users#update_profile'
    get 'users/account', to: 'users#account'
  end

  get '/search', to: 'searches#search', as: :search

  root 'rooms#index'
  get 'rooms/index'
  get 'rooms/new'
  get 'rooms/own', to: 'rooms#own', as: :own_rooms
  
  devise_for :users
  resources :rooms
  resources :reservations do
    member do
      get 'edit_confirmation'
      patch 'edit_confirmation', to: 'reservations#edit_confirmation'
    end
    collection do
      post 'confirmation'
    end
  end
  get 'own_reservations', to: 'reservations#own', as: 'own_reservations'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end