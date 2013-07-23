Preunion::Application.routes.draw do

  get '/users/auth/github/callback', to: 'sessions#create'
  resources :users
  resources :sessions

  root to: 'home#index'
end
