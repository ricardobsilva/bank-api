require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :request do
  describe 'POST #registrations' do
    context 'when pass valid attributes' do
      it 'return 201 status code' do
        user_params = attributes_for(:user)

        post '/api/v1/auth', params: { user: user_params}

        expect(response).to have_http_status(:created)
      end

      it 'return object user with attributes' do
        user_params = attributes_for(:user)

        post '/api/v1/auth', params: { user: user_params}

        expect(json_body).to include(:user)
        expect(json_body[:user]).to include(:email)
        expect(json_body[:user]).to include(:name)
        expect(json_body[:user]).to include(:cpf)
      end
    end

    context 'when pass invalid attributes' do
      it 'return 422 status code' do
        user_params = attributes_for(:user, email: nil)

        post '/api/v1/auth', params: { user: user_params}

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return object errors' do
        user_params = attributes_for(:user, email: nil)

        post '/api/v1/auth', params: { user: user_params}

        expect(json_body).to include(:errors)
      end
    end
  end
end
