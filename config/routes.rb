Rails.application.routes.draw do

  resources :line_items
  resources :carts
  resources :books do
    # Do I  really need  #new action?
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
  # delete 'devise/registrations', to: 'devise/registrations#destroy'


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
