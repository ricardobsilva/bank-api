class Api::V1::Accounts::Create
  include Wisper::Publisher

  def initialize(params)
    @params = params
  end

  def call
    account = Account.new(@params)
    return broadcast(:failed, account) unless account.valid?

    account.save
    broadcast(:success, account)
  end
end
