require 'rails_helper'

RSpec.describe Api::V1::BankTransfersController, type: :request do
  let(:headers){
    user = create(:user)
    headers = get_headers({ email: user.email, password: user.password })
  }

  describe 'POST #create' do
    context 'when pass valid attributes' do
      it 'return 201 status code' do
        source_account = create(:account, total_amount: 500.0)
        destination_account = create(:account)

        bank_transfer_params = attributes_for(:bank_transfer,
                                              amount: 200.0,
                                              source_account_id: source_account.id,
                                              destination_account_id: destination_account.id)

        post '/api/v1/bank_transfers', params: { bank_transfer: bank_transfer_params}, headers: headers

        expect(response).to have_http_status(:created)
      end

      it 'return Bank Transfer object' do
        source_account = create(:account, total_amount: 500.0)
        destination_account = create(:account)

        bank_transfer_params = attributes_for(:bank_transfer,
                                              amount: 200.0,
                                              source_account_id: source_account.id,
                                              destination_account_id: destination_account.id)

        post '/api/v1/bank_transfers', params: { bank_transfer: bank_transfer_params}, headers: headers

        expect(json_body).to include(:bank_transfer)
        expect(json_body[:bank_transfer]).to include(:source_account_number)
        expect(json_body[:bank_transfer]).to include(:destination_account_number)
        expect(json_body[:bank_transfer]).to include(:amount)
        expect(json_body[:bank_transfer]).to include(:created_at)
      end
    end

    context 'when pass invalid attributes' do
      it 'return 422 status code' do
        destination_account = create(:account)
        source_account = create(:account)

        invalid_bank_transfer_params = attributes_for(:bank_transfer,
                                                      amount: nil,
                                                      source_account_id: source_account.id,
                                                      destination_account_id: destination_account.id)

        post '/api/v1/bank_transfers', params: { bank_transfer: invalid_bank_transfer_params}, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return errors object' do
        destination_account = create(:account)
        source_account = create(:account)

        invalid_bank_transfer_params = attributes_for(:bank_transfer,
                                                      amount: nil,
                                                      source_account_id: source_account.id,
                                                      destination_account_id: destination_account.id)

        post '/api/v1/bank_transfers', params: { bank_transfer: invalid_bank_transfer_params}, headers: headers

        expect(json_body).to include(:errors)
      end
    end

    context 'when the original account do not have sufficient bank balance' do
      it 'return 422 status code' do
        source_account = create(:account, total_amount: 100.0)
        destination_account = create(:account)

        bank_transfer_params = attributes_for(:bank_transfer,
                                              amount: 300.0,
                                              source_account_id: source_account.id,
                                              destination_account_id: destination_account.id)

        post '/api/v1/bank_transfers', params: { bank_transfer: bank_transfer_params}, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #check_bank_balance' do
    context 'when find the account id' do
      it 'return 200 https status code' do
        account = create(:account)
        bank_transfer = create_list(:bank_transfer, 3, source_account_id: account.id)

        get "/api/v1/bank_transfers/check_account_bank_balance/#{account.id}", headers: headers

        expect(response).to have_http_status(:ok)
      end

      it 'return account with attributes' do
        account = create(:account)
        bank_transfer = create_list(:bank_transfer, 3, source_account_id: account.id)

        get "/api/v1/bank_transfers/check_account_bank_balance/#{account.id}", headers: headers

        expect(json_body).to include(:account)
        expect(json_body[:account]).to include(:account_number)
        expect(json_body[:account]).to include(:total_amount)
      end
    end

    context 'when do not find the account id' do
      it 'return 404 https status code' do
        account = create(:account)
        bank_transfer = create_list(:bank_transfer, 3, source_account_id: account.id)
        invalid_account_id = account.id + 1

        get "/api/v1/bank_transfers/check_account_bank_balance/#{invalid_account_id}", headers: headers

        expect(response).to have_http_status(:not_found)
      end

      it 'return a message informing that the account was not found' do
        account = create(:account)
        bank_transfer = create_list(:bank_transfer, 3, source_account_id: account.id)
        invalid_account_id = account.id + 1

        get "/api/v1/bank_transfers/check_account_bank_balance/#{invalid_account_id}", headers: headers

        expect(json_body).to include(:message)
        expect(json_body[:message]).to include('account not found')
      end
    end
  end
end
