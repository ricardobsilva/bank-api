require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :request do
  describe 'POST #create' do
    context 'when pass valid attributes' do
      it 'return 201 status code' do
        user = create(:user)
        account_params = attributes_for(:account, user_id: user.id)

        post '/api/v1/accounts', params: { account: account_params}

        expect(response).to have_http_status(:created)
      end

      it 'return object account with attributes' do
        user = create(:user)
        account_params = attributes_for(:account, user_id: user.id)

        post '/api/v1/accounts', params: { account: account_params}

        expect(json_body).to include(:account)
        expect(json_body[:account]).to include(:account_number)
        expect(json_body[:account]).to include(:bank)
        expect(json_body[:account]).to include(:agency)
        expect(json_body[:account]).to include(:total_amount)
        expect(json_body[:account]).to include(:user_id)
      end
    end

    context 'when pass invalid attributes' do
      it 'return 422 status code' do
        user = create(:user)
        account_params = attributes_for(:account, account_number: nil, user_id: user.id)

        post '/api/v1/accounts', params: { account: account_params}

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return object errors' do
        user = create(:user)
        account_params = attributes_for(:account, account_number: nil, user_id: user.id)

        post '/api/v1/accounts', params: { account: account_params}

        expect(json_body).to include(:errors)
      end
    end
  end
end
