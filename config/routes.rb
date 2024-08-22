Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'roots#show'

  resources :notebooks, only: %i[index new edit create update destroy] do
    resources :pages, only: [:index, :create]
  end
  resources :pages, only: %i[edit update destroy]

  resources :current_notebooks, only: :update
  resource :tree, only: :show
  resource :user, only: :show
  resource :need_mail_confirmation, only: :show

  resources :houseworks, only: %i[index new create edit update destroy]
  resources :housework_logs, only: %i[create destroy]

  resources :projects, only: %i[index show new create edit update destroy]
  resources :project_parts, only: %i[index show new create edit update destroy]
  resources :characters, only: %i[index show new create edit update destroy]
end
