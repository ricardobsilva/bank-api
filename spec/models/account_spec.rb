require 'rails_helper'

RSpec.describe Account, type: :model do
  it{ is_expected.to validate_presence_of(:account_number) }
  it{ is_expected.to validate_uniqueness_of(:account_number)}
  it{ is_expected.to validate_presence_of(:agency) }
  it{ is_expected.to validate_presence_of(:bank) }
  it{ is_expected.to validate_presence_of(:total_amount) }

  it { is_expected.to define_enum_for(:bank).with_values([:santander, :caixa,
                                                          :bradesco, :itau]) }
end
