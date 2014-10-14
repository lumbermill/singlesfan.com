Rails.application.routes.draw do
  resources :pictures
  resources :events

  namespace :for_master do
    root 'pages#index'
    get 'calc' => 'pages#calc'
  end

  # Fixed pages
  root 'pages#index'
  get 'about' => 'pages#about'
  get 'foodmenu' => 'pages#foodmenu'
  get 'access' => 'pages#access'

  get 'pasts' => 'events#pasts'  
  get 'plain' => 'events#plain'  

  # Manage masters
  get 'login' => 'sessions#new'  # why is it needed? , :as => 'login'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'master/reset' => 'masters#reset'
  post 'master/reset' => 'masters#reset_do'
  get 'master/new' => 'masters#new'
  post 'master/new' => 'masters#new_do'

  get 'img/:id' => 'pictures#show_image'
  get 'thumb/:id' => 'pictures#show_thumb'
  get 'imgs' => 'pictures#show_images'
  
end
