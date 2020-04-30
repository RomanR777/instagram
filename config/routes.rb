Rails.application.routes.draw do
  devise_for :users
  resources :comments
  resources :posts do
    get 'followee', on: :member
    post 'like', on: :member
    delete 'dislike', on: :member
    get 'search', on: :collection
  end
  resources :follows
  get '/profiles/:nickname(/:action)', controller: 'profiles', action: 'view', as: 'view_profile'
  get '/profiles', controller: 'profiles', action: 'index'
  root 'main#index'
end
