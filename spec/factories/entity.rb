# spec/factories/entities.rb
FactoryBot.define do
  factory :entity do
    name { Faker::Lorem.word }
    amount { Faker::Number.between(from: 1, to: 1000) }
    association :user
  end
end
