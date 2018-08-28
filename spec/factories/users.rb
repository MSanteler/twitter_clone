FactoryBot.define do
  factory :user do
    name { Faker::GameOfThrones.character }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
