FactoryBot.define do
  factory :tweet do
    user { nil }
    content { Faker::GameOfThrones.quote }
  end
end
