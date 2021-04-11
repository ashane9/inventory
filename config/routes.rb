Rails.application.routes.draw do
  root 'home#index'
  get 'home/new_autograph'
  get 'items/search', to: 'items#search'
  post 'autographs/get_item', to: 'autographs#get_item'
  get 'reset', to: 'home#reset'
  resources :values
  resources :purchase_types
  resources :authentications
  resources :item_types
  resources :purchases
  resources :images
  resources :autographs
  #get 'items/search_result', to: 'items#search_result'
  resources :items
  get :autocomplete, to: 'autographs#autocomplete'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #login authentication
  get '/dashboard' => 'dashboard#show'

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'
end
