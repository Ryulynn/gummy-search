Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#top'
  get    '/sample',  to: 'samples#index'
  get    '/about',   to: 'home#about'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    'users/:id/review', to: 'users#review'
  get    'users/:id/map', to: 'users#map'
  get    'gummies/:id/map', to: 'gummies#map'
  resources :users
  resources :gummies
  resources :flavors, :only => [:index, :new, :create]
  resources :makers, :only => [:index, :new, :create]
  resources :reviews
  resources :spots
  resources :admins, :only => [:index]
end
