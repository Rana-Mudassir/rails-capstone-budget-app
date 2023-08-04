FactoryBot.define do
  factory :group do
    name { Faker::Lorem.word }
    icon { Faker::Lorem.word }
    association :user
  end
end
