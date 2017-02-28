Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "businesses#index"
  get 'ui(/:action)', controller: 'ui'
  resources :businesses, only: [:index, :show, :new, :create]
end
