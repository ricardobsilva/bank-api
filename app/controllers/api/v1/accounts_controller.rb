class Api::V1::AccountsController < ApplicationController

  def create
    command_create = Api::V1::Accounts::Create.new(account_params)
    command_create.on(:success){|account|
                                render json: account,
                                       status: :created,
                                       serializer: Api::V1::Accounts::AccountSerializer
                               }

    command_create.on(:failed){|account| render json: { errors: account.errors },
                                                status: :unprocessable_entity}
    command_create.call
  end

  private

  def account_params
    params.require(:account).permit(:account_number, :agency, :bank,
                                    :total_amount, :user_id)
  end
end
