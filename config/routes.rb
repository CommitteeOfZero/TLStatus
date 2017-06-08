Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#auth_failure'
  get '/logout', to: 'sessions#destroy'

  root 'projects#index'
  resources :projects, except: :destroy
  get '/projects/:id/download', to: 'projects#download', as: :download_project
  get '/projects/:id/style_guide', to: 'projects#style_guide', as: :style_guide
  patch '/projects/:id/style_guide', to: 'projects#update_style_guide'
  put '/projects/:id/style_guide', to: 'projects#update_style_guide'
  resources :users
  resources :project_memberships, only: [:create, :destroy]
  resources :scripts, only: [:edit, :update]
  get '/scripts/:id/version/:version', to: 'scripts#version', as: :version_of_script
  get '/scripts/:id/compare/:first..:second', to: 'scripts#compare', as: :diff_script
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
