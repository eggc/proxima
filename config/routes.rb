Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get "up" => "rails/health#show", as: :rails_health_check

  root 'roots#show'

  resources :current_workspaces, only: :update
  resource :tree, only: :show
  resource :user, only: :show
  resources :ideas, only: [:index, :create, :edit, :update, :destroy]
  resources :projects, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :project_parts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :characters, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
