Rails.application.routes.draw do
  root to: 'home#index'

  resources :user_sessions
  resources :users
  resources :articles

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
end
