FactoryBot.define do
  factory :bank_transfer do
    association :source_account, factory: :account
    association :destination_account, factory: :account
    amount { Faker::Number.normal(rand(1..500)).truncate(2) }
  end
end
