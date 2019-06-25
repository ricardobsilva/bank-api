class Api::V1::BankTransfers::CreateSerializer < ActiveModel::Serializer
  attributes :source_account_number, :destination_account_number, :amount, :created_at

  def source_account_number
    object.source_account.account_number
  end

  def destination_account_number
    object.destination_account.account_number
  end
end
