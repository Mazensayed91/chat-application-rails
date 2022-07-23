Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :applications
      resources :chats
      post 'applications/:application_token/chats', to: 'chats#create'
      get 'applications/:application_token/chats', to: 'chats#show'
      get 'applications/:application_token/chats/:chat_num/messages', to: 'messages#show'
      post 'applications/:application_token/chats/:chat_num/messages', to: 'messages#create'

    end
  end


end
