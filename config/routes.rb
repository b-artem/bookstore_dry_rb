# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books, only: %i[index show] do
    resources :reviews, only: :create
  end
  resources :carts, only: %i[show update]
  resources :line_items, only: %i[create update destroy]
  resources :orders, controller: 'orders/orders', only: %i[index show create] do
    resources :checkout, controller: 'orders/checkout', only: %i[index show update]
  end

  root 'home#index'
  get 'home/index'
  get 'settings/edit'
  put 'settings/update'
  patch 'settings/update_email'
  patch 'settings/change_password'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
