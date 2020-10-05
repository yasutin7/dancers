FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(8)
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password_digest { password }
  end
end
