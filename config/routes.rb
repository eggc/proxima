Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get "up" => "rails/health#show", as: :rails_health_check

  root 'roots#show'

  resources :workspaces, only: [:new, :edit, :create, :update, :destroy]
  resources :current_workspaces, only: :update
  resource :tree, only: :show
  resource :user, only: :show

  resources :dots, only: [:index, :create, :edit, :update, :destroy]
  resources :dot_tasks, only: [:create]

  resources :houseworks, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :housework_logs, only: [:create, :destroy]

  resources :projects, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :project_parts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :characters, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
