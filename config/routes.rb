Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'

  root to: 'home#index'

  resources :user_sessions
  resources :users
  resources :articles
  resources :vue_articles

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
end
