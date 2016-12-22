Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
    
    resources :products
  end

  devise_for :users

  root "store#index"
end
