class Api::V1::BankTransfers::Create
  include Wisper::Publisher

  def initialize(params)
    @params = params
    @bank_transfer = BankTransfer.new(@params)
    @source_account = Account.find(@params[:source_account_id])
    @destination_account = Account.find(@params[:destination_account_id])
    @amount = @params[:amount].to_f
  end

  def call
    return bank_transfer_failed  unless @bank_transfer.valid?

    execute_bank_transfer
  end

  private

  def execute_bank_transfer
    return broadcast(:insufficient_balance) if has_limit?

    debit_amount_in_original_account
    credit_amount_in_destination_account

    bank_transfer_success
  end

  def has_limit?
    @source_account.total_amount < @amount
  end

  def debit_amount_in_original_account
    @source_account.total_amount = @source_account.total_amount - @amount
    @source_account.save
  end

  def credit_amount_in_destination_account
    @destination_account.total_amount = @destination_account.total_amount + @amount
    @destination_account.save
  end

  def bank_transfer_success
    @bank_transfer.save
    broadcast(:success, @bank_transfer)
  end

  def bank_transfer_failed
    broadcast(:failed, @bank_transfer)
  end
end
