Rails.application.routes.draw do
  root to: 'items#index'
  resources :items, only: [:index, :show]
  resources :cart_items, only: [:create, :index]
end
