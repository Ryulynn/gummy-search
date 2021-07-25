Rails.application.routes.draw do
  get 'gummies/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#top'
  get    '/sample',  to: 'samples#index'
  get    '/about',   to: 'home#about'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, :except => :index
  resources :gummies
  resources :flavors, :only => [:new, :create]
end
