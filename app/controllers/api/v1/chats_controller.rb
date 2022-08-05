module Api
  module V1
    class ChatsController < ApplicationController
      protect_from_forgery with: :null_session

      def show
        cached_chats = Rails.cache.read("get_chats-"+params[:application_token])

        if !cached_chats.blank?
          render json: {status: 'SUCCESS', message: 'Loaded Chats', data: cached_chats.as_json(only: [:chat_num, :messages_count, :created_at])}, status: :ok
          return
        end
        application = Application.where(token: params[:application_token])

        if application
          chats = application[0].chats
          Rails.cache.write("get_chats-"+params[:application_token], chats, expire_in: 5.minutes)
          render json: {status: 'SUCCESS', message: 'Loaded Chats', data: chats.as_json(only: [:chat_num, :messages_count, :created_at])}, status: :ok
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
            # Call async method to update chats_count of this application as the chat is saved
            UpdateChatsCountJob.perform_later(params[:application_token])

            Rails.cache.delete("get_chats-"+params[:application_token])

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
