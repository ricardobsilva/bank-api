class Api::V1::BankTransfers::CheckBalanceSerializer < ActiveModel::Serializer
  attributes :account_number, :total_amount

  def account_number
    object.source_account.account_number
  end

  def total_amount
    object.source_account.total_amount
  end
end
