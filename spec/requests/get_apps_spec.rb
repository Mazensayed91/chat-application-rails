require 'rails_helper'

RSpec.describe 'testing_app_happy_scenario', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:application, 10)
      get '/api/v1/applications'
    end

    it 'returns all apps' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end