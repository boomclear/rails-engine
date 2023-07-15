Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end
  
  get "/api/v1/merchants/:merchant_id/items", to: "api/v1/items#merchant_index"
  get "/api/v1/items/:id/merchant", to: "api/v1/items#merchant_show"
  get "/api/v1/merchants/find", to: "api/v1/merchants#find"
end
