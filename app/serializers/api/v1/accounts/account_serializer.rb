class Api::V1::Accounts::AccountSerializer < ActiveModel::Serializer
  attributes :account_number, :bank, :agency, :total_amount, :user_id
end
