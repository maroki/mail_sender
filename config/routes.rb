Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'home#index'

  resources :games
  resources :users
  resources :mailings
end
