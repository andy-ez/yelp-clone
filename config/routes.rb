Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "businesses#index"
  get 'ui(/:action)', controller: 'ui'
  resources :businesses, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
  end
  get 'register', to: 'users#new'
  get 'login', to: "sessions#new"
  get 'logout', to: "sessions#destroy"
  resources :sessions, only: [:create]
  resources :users, only: [:create, :show]
  resources :reviews, only: [:index]
end
