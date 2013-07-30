Preunion::Application.routes.draw do
  get 'instruction', to: 'home#instruction'
  get '/auth/github/callback', to: 'sessions#auth'

  get 'users/edit', to: 'users#edit'
  delete 'session/destroy', to: 'sessions#destroy'
  resources :users, except: [:edit]
  resources :sessions, except: [:destroy]
  resources :projects
  resources :ranking, only: [:index]

  root to: 'home#index'
end
