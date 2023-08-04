Rails.application.routes.draw do
  devise_for :users

  unauthenticated do
    root to: 'home#index', as: 'home_root'
  end

 
  root 'groups#index'

  resources :groups do
    resources :entities
  end
end
