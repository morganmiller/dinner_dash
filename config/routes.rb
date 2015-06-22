Rails.application.routes.draw do
  root to: 'items#index'
  resources :items, only: [:index, :show]
  resources :cart_items, only: [:create, :index]
  resources :users, only: [:new, :create]
  resources :categories, only: [:show]
  resources :orders, only: [:create, :index, :show]

  namespace :admin do
    root to: 'items#index'
    resources :items
    resources :orders
    resources :categories
  end

  get '/cart', to: 'cart#show'
  post '/cart', to: 'cart#create'
  delete '/cart_items', to: 'cart_items#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
