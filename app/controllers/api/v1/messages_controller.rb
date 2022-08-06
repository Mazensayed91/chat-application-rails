module Api
  module V1
    class MessagesController < ApplicationController
      protect_from_forgery with: :null_session

      def show
        cached_messages = Rails.cache.read('get_messages-' + params[:application_token] + '-' + params[:chat_num])

        unless cached_messages.blank?
          render json: { status: 'SUCCESS', message: 'Loaded messages', data: cached_messages.as_json(only: %i[message_num created_at content]) },
                 status: :ok
          return
        end

        application = Application.where(token: params[:application_token])

        if application[0]
          chats = application[0].chats
          if chats[0]
            messages = chats.where(chat_num: params[:chat_num])[0].messages
            Rails.cache.write('get_messages-' + params[:application_token] + '-' + params[:chat_num], messages,
                              expire_in: 5.minutes)
            render json: { status: 'SUCCESS', message: 'Loaded messages', data: messages.as_json(only: %i[message_num created_at content]) },
                   status: :ok
          else
            render json: { status: 'ERROR' }, status: :not_found
          end
        else
          render json: { status: 'ERROR' }, status: :not_found
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

            # Call async method to create the chat record
            CreateMessageJob.perform_later(chat[0], current_message_number, params[:content])
            Rails.cache.delete('get_messages-' + params[:application_token] + '-' + params[:chat_num])

            # Call async method to update messages_count of this chat.
            UpdateMessagesCountJob.perform_later(params[:application_token], params[:chat_num])
            render json: { status: 'SUCCESS', message: 'Create message', data: { message_num: current_message_number, content: params[:content] } },
                   status: :ok
          end
        else
          render json: { status: 'ERROR' }, status: :not_found
        end
      end

      def search
        application = Application.where(token: params[:application_token])

        if application[0]
          chats = application[0].chats
          chat = chats.where(chat_num: params[:chat_num])
          if chat[0]
            search_results = Message.search(params[:query], params[:chat_num])
            render json: { status: 'SUCCESS', message: 'Matched Messages', data: search_results.as_json(only: %i[message_num content chat_id]) },
                   status: :ok
          else
            render json: { status: 'chat not found' }, status: :not_found
          end
        else
          render json: { status: 'application not found' }, status: :not_found
        end
      end
    end
  end
end
