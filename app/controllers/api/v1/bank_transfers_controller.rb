class Api::V1::BankTransfersController < ApplicationController
  def create
    command_create = Api::V1::BankTransfers::Create.new(bank_transfer_params)
    command_create.on(:success){|bank_transfer|
      render json: bank_transfer, status: :created,
             serializer: Api::V1::BankTransfers::CreateSerializer
    }

    command_create.on(:failed){|bank_transfer|
      render json: {errors: bank_transfer.errors}, status: :unprocessable_entity
    }

    command_create.on(:insufficient_balance){|bank_transfer|
      render json: {message: 'There is not enough balance to complete this transaction'},
             status: :unprocessable_entity
    }
    command_create.call
  end

  private

  def bank_transfer_params
    params.require(:bank_transfer).permit(:source_account_id,
                                          :destination_account_id, :amount)
  end
end
