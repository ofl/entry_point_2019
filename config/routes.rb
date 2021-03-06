Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'

  root to: 'home#index'

  resources :users, param: :name, only: [:show] do
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end
  resource :profile, only: [:show, :edit]

  resources :articles
  resources :vue_articles
  resources :spa_articles, only: [:index, :show, :new, :edit]
  resources :inline_gql_articles, only: [:index, :show, :new, :edit]
  resources :favorites, only: [:index]

  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  get 'sign_up', to: 'account#new', as: :sign_up
end
