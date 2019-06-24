class Api::V1::Registrations::UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :cpf
end
