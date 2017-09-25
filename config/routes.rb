Rails.application.routes.draw do
  resources :line_items
  resources :carts
  resources :books do
    resources :reviews, except: [:new, :index]
  end
  resources :orders, controller: 'orders/orders' do
    resources :checkouts, controller: 'orders/checkouts'
  end
  resources :addresses, only: [:create, :update]
  resources :billing_addresses

  root 'home#index'
  get 'home/index'
  get 'settings/edit'
  put 'settings/update'
  patch 'settings/update_email'
  patch 'settings/change_password'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
end
