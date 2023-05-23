Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get '/signup', to: 'users#new'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  root 'cafes#index'
  resources :users, only: %i[create destroy]
  resource :profiles, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  resources :cafes, only: %i[index show]
end
