class Account < ApplicationRecord
  validates :account_number, presence: true, uniqueness: true
  validates :agency, presence: true
  validates :bank, presence: true
  validates :total_amount, presence: true

  has_many :bank_transfers, foreign_key: 'source_account_id'
  has_many :source_accounts, through: :bank_transfers

  has_many :bank_transfers, foreign_key: 'destination_account_id'
  has_many :destination_accounts, through: :bank_transfers

  belongs_to :user

  enum bank: { santander: 0, caixa: 1, bradesco: 2, itau: 3 }
end
