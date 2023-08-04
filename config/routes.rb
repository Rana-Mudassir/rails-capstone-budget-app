Rails.application.routes.draw do
  devise_for :users

  resources :groups do
    resources :entities
  end

  # Defines the root path route ("/")
  root "home#index"
end
