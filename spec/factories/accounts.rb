FactoryBot.define do
  factory :account do
    account_number { Faker::Bank.account_number }
    agency { Faker::Bank.account_number(3) }
    bank { :santander }
    total_amount { Faker::Number.normal(rand(1..500)).truncate(2) }
    association :user
  end
end
