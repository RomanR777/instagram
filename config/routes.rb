Rails.application.routes.draw do
  devise_for :users
  resources :comments
  resources :posts
  resources :likes
  resources :follows
  get '/profiles/:nickname(/:action)', controller: 'profiles', action: 'view', as: 'view_profile'
  get '/profiles', controller: 'profiles', action: 'index'
  root 'main#index'
end
