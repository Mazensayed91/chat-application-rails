module Api
  module V1
    class ApplicationsController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        cached_apps = Rails.cache.read("applications")

        if !cached_apps.blank?
          render json: {status: 'SUCCESS', message: 'Loaded Apps', data: cached_apps}, status: :ok
          return
        end

        applications = Application.order('created_at DESC');
        Rails.cache.write("applications", applications, expire_in: 5.minutes)
        render json: {status: 'SUCCESS', message: 'Loaded Apps', data: applications}, status: :ok
      end

      def create
        Rails.cache.delete("applications")
        token = create_token;
        # Call async method to create the app record
        CreateAppJob.perform_later(params[:name], token)
        render json: {status: 'SUCCESS', message: 'app is being created', data: {token: token, name: params[:name]}}, status: :ok
      end

      def show
        # get the application using token_index
        application = Application.where(token: params[:id])
        if application
          render json: {status: 'SUCCESS', data: application.as_json(only: [:token, :name, :created_at, :chats_count])}, status: :ok
        else
          render json: {status: 'ERROR'}, status: :not_found
        end
      end

      private
      def create_token
        token = loop do
          random_token = SecureRandom.urlsafe_base64(nil, false)
          break random_token
        end
        token
      end


    end
  end
end
