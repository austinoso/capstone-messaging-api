Rails.application.routes.draw do
  resources :messages, except: [:index]
  resources :chats, except: [:index]
  resources :contacts, except: [:index]
  resources :users, except: [:index]
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      #get '/profile', to: 'users#profile'
    end
  end 
end
