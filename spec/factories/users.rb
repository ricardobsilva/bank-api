FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    cpf { CNPJ.generate }
  end
end
