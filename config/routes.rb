Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#auth_failure'
  get '/logout', to: 'sessions#destroy'

  root 'projects#index'
  resources :projects
  resources :users
  resources :project_memberships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
