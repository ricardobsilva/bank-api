class Api::V1::BankTransfers::CheckBalance
  include Wisper::Publisher

  def initialize(account_id)
    @account_id = account_id
  end

  def call
    account = BankTransfer.where(source_account_id: @account_id).last

    return broadcast(:account_not_found, account) if account.nil?

    broadcast(:success, account)
  end
end
