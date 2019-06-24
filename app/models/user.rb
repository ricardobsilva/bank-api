class User < ApplicationRecord
  validates :name, presence: true
  validates :cpf, presence: true
end
