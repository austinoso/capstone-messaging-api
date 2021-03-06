Rails.application.routes.draw do
  resources :messages, except: [:index]
  resources :chats
  
  resources :contacts, except: [:index]
  resources :users, except: [:index]
  
  get 'chats/:id/messages', to: 'chats#messages'

  mount ActionCable.server => '/cable'
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
    end
  end 
end
