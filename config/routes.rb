Rails.application.routes.draw do
  resources :messages
  resources :chats
  resources :contacts, except: [:index]
  resources :users, except: [:index]

  mount ActionCable.server => '/cable'
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      #get '/profile', to: 'users#profile'
    end
  end 
end
