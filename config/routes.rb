Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  root 'users#index'
  resources :users, only: %i[create destroy]
  resource :profiles, only: %i[show edit update]
end
