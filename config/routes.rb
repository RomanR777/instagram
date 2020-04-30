Rails.application.routes.draw do
  devise_for :users
  root 'main#index'
  resources :comments
  resources :posts do
    get 'followee', on: :member
    put 'like', on: :member
    delete 'dislike', on: :member
    get 'search', on: :collection
  end

  # profiles
  get '/profiles/:nickname(/:action)', controller: 'profiles', action: 'view', as: 'view_profile'
  get '/profiles', controller: 'profiles', action: 'index'

  #followings
  get '/follows/:id', to: 'follows#show', as: 'follows'
  post '/follow/:id', to: 'follows#create', as: 'follow'
  delete '/unfollow/:id', to: 'follows#destroy', as: 'unfollow'
end
