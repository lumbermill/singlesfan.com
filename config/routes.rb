Rails.application.routes.draw do
  resources :pictures
  resources :events
  resources :masters

  namespace :master do
    root 'pages#index'
    get 'calc' => 'pages#calc'
  end

  root 'pages#index'
  get 'about' => 'pages#about'
  get 'foodmenu' => 'pages#foodmenu'
  get 'access' => 'pages#access'

  get 'pasts' => 'events#pasts'  
  get 'plain' => 'events#plain'  

  get 'login' => 'sessions#new'  # why is it needed? , :as => 'login'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'img/:id' => 'pictures#show_image'
  get 'thumb/:id' => 'pictures#show_thumb'
  get 'imgs' => 'pictures#show_images'
end
