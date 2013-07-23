Preunion::Application.routes.draw do

  get '/auth/github/callback', to: 'sessions#create'
  resources :users
  resources :sessions

  root to: 'home#index'
end
