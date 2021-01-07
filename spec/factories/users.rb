FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email(name: username) }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
