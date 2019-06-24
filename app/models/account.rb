class Account < ApplicationRecord
  validates :account_number, presence: true, uniqueness: true
  validates :agency, presence: true
  validates :bank, presence: true
  validates :total_amount, presence: true

  belongs_to :user

  enum bank: { santander: 0, caixa: 1, bradesco: 2, itau: 3 }
end
