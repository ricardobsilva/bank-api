require 'rails_helper'

RSpec.describe BankTransfer, type: :model do
  it{ is_expected.to belong_to(:source_account) }
  it{ is_expected.to belong_to(:destination_account) }
end
