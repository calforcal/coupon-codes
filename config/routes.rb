Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "application#welcome" # NEED HELP 1


  resources :merchants do 
    resources :items , only: [:index, :show, :new, :create, :edit, :update], controller: "merchants/items"
    resources :invoices , only: [:index, :show], controller: "merchants/invoices"
    resources :coupons, only: [:index, :new, :create, :show, :update], controller: "merchants/coupons"
  end

  resources :invoice_items, only: [:update]

  get "/admin", to: "admin/dashboards#welcome"

  namespace :admin do
    resources :merchants, only: [:index, :new, :create, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
































end
