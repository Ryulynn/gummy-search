Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/sample', to: 'samples#index'
  root to: 'home#top'
  get '/about', to: 'home#about'
end
