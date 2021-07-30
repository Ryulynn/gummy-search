Rails.application.routes.draw do
  get 'makers/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#top'
  get    '/sample',  to: 'samples#index'
  get    '/about',   to: 'home#about'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    'users/:id/review', to: 'users#review'
  get    'users/:id/map', to: 'users#map'
  resources :users, :except => :index
  resources :gummies
  resources :flavors, :only => [:new, :create]
  resources :flavors, :only => [:new, :create]
  resources :reviews
end
