Rails.application.routes.draw do
  devise_for :users
  resources :friends
  get 'home/about'
  get 'home/index'
  # root 'home#index'
  root 'friends#index'
end
