Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount ActionCable.server => '/cable'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get '/signup', to: 'users#new'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  post 'webhook', to: 'line_bot#callback'
  root 'cafes#index'

  # LINEログイン
  get 'line_login_api/login', to: 'line_login_api#login'
  get 'line_login_api/callback', to: 'line_login_api#callback'

  # sorcery LINEログイン
  post "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :users, only: %i[show create destroy]
  resource :profiles, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  resources :cafes, only: %i[index show]
  resources :likes, only: %i[create destroy]
  resources :rooms, only: %i[index show create]
  resources :messages, only: :create

  resources :notifications, only: %i[index show] do
    collection do
      post 'all_read'
    end
  end
end
