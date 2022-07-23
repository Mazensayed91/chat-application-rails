module Api
  module V1
    class ChatsController < ApplicationController
      protect_from_forgery with: :null_session

      def show
        application = Application.where(token: params[:id])

        if application
          print(Chat.where(application_id: application.as_json[0][:id]).explain)
          chats = application[0].chats

          render json: {status: 'SUCCESS', message: 'Loaded Apps', data: chats}, status: :ok
        else
          render json: {status: 'ERROR'}, status: :not_found
        end
      end

      def create
        application = Application.where(token: params[:application_token])

        if application
          last_chat_number = application[0].chats.maximum(:chat_num)
          current_chat_number = last_chat_number ? last_chat_number + 1 : 1

          chat = application[0].chats.create({chat_num: current_chat_number})

          if chat.save
            render json: {status: 'SUCCESS', message: 'Create app', data: chat.as_json(only: [:chat_num, :created_at])}, status: :ok
          else
            render json: {status: 'ERROR', message: 'Application not created', data: chat.errors }, status: :unprocessable_entity
          end

        else
          render json: {status: 'ERROR'}, status: :not_found
        end
      end

    end
  end
end
