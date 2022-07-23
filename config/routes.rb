Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :applications
      resources :chats
      post 'applications/:application_token/chats', to: 'chats#create'
    end
  end


end
