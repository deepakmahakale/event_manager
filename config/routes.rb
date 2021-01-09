Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events
  resources :users
  resources :user_events, only: [:update]

  get :my_events, to: 'user_events#my_events'

  root to: 'events#index'
end
