Rails.application.routes.draw do
  devise_for :users

  resources :bank_accounts, only: %i[index new create destroy]
  resources :transactions, only: %i[new create]

  namespace :admin do
    resources :users
    resources :dashboards, only: [:index]
    resources :keys, only: [:index, :destroy]
    resources :bank_accounts, only: [:index]
    root 'dashboards#index'
  end

  # Defines the root path route ("/")
  root 'welcome#index'
  get '/admin', to: 'dashboard#index'
end
