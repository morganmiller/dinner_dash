Rails.application.routes.draw do
  root to: 'items#index'
  resources :items, only: [:index, :show]
  resources :cart_items, only: [:create, :index]
  resources :users, only: [:new, :create]

  get '/cart', to: 'cart#show'
  post '/cart', to: 'cart#create'
  delete '/cart_items', to: 'cart_items#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
