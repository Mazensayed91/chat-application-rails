module Api
  module V1
    class MessagesController < ApplicationController
      protect_from_forgery with: :null_session

      def show
        application = Application.where(token: params[:application_token])

        if application[0]
          chats = application[0].chats
          if chats[0]
            messages = chats.where(chat_num: params[:chat_num])[0].messages
            render json: {status: 'SUCCESS', message: 'Loaded messages', data: messages.as_json(only: [:message_num, :created_at, :content])}, status: :ok
          else
            render json: {status: 'ERROR'}, status: :not_found
          end
        else
          render json: {status: 'ERROR'}, status: :not_found
        end
      end

      def create
        application = Application.where(token: params[:application_token])

        if application[0]
          chats = application[0].chats
          chat = chats.where(chat_num: params[:chat_num])
          if chat[0]
            last_message_number = chat[0].messages.maximum(:message_num)
            current_message_number = last_message_number ? last_message_number + 1 : 1

            message = chat[0].messages.create({message_num: current_message_number, content: params[:content]})
            if message.save
              UpdateMessagesCountJob.perform_later(params[:application_token], params[:chat_num])
              render json: {status: 'SUCCESS', message: 'Create message', data: message.as_json(only: [:message_num, :created_at, :content])}, status: :ok
            else
              render json: {status: 'ERROR', message: 'message not created', data: message.errors }, status: :unprocessable_entity
            end

          end
        else
          render json: {status: 'ERROR'}, status: :not_found
        end
      end

      def search
        application = Application.where(token: params[:application_token])

        if application[0]
          chats = application[0].chats
          chat = chats.where(chat_num: params[:chat_num])
          if chat[0]
            search_results = Message.search(params[:query], params[:chat_num])
            render json: {status: 'SUCCESS', message: 'Matched Messages', data: search_results.as_json(only: [:message_num, :content, :chat_id])}, status: :ok
          else
            render json: {status: 'chat not found'}, status: :not_found
          end
        else
          render json: {status: 'application not found'}, status: :not_found
        end
      end
    end
  end
end

