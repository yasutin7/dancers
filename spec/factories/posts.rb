FactoryBot.define do
  factory :post do
    content { Faker::Lorem.characters(number: 5) }
    condition { Faker::Lorem.characters(number: 20) }
    user
  end
end
