Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "application#welcome" # NEED HELP 1


  resources :merchants do 
    resources :items , only: [:index, :show, :new, :create, :edit, :update], controller: "merchants/items"
    resources :invoices , only: [:index, :show], controller: "merchants/invoices"
    resources :coupons, only: [:index, :new, :create], controller: "merchants/coupons"
  end

  # get "/merchants/:id/items", to: "merchants/items#index"
  # get "/merchants/:id/items/new", to: "merchants/items#new"
  # post "/merchants/:id/items", to: "merchants/items#create"
  # get "/merchants/:id/items/:id", to: "merchants/items#show"
  # get "/merchants/:id/items/:id/edit", to: "merchants/items#edit"
  # patch "/merchants/:id/items/:id", to: "merchants/items#update"

  # get "/merchants/:id/invoices", to: "merchants/invoices#index"
  # get "/merchants/:id/invoices/:id", to: "merchants/invoices#show"

  resources :invoice_items, only: [:update]
  # patch "/invoice_items/:id", to: "invoice_items#update"

  get "/admin", to: "admin/dashboards#welcome"

  namespace :admin do
    resources :merchants, only: [:index, :new, :create, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
































end
