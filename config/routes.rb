Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'

  root to: 'home#index'

  resources :users
  resources :articles
  resources :vue_articles
  resources :spa_articles, only: [:index, :show, :new, :edit]

  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
end
