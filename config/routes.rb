Preunion::Application.routes.draw do
  get 'instruction', to: 'home#instruction'
  get '/auth/github/callback', to: 'sessions#auth'

  resources :users
  resources :sessions
  resources :projects

  root to: 'home#index'
end
