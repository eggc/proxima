Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root 'roots#show'
  resource :tree, only: :show
  resource :user, only: :show
  resources :projects, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :project_parts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :characters, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
