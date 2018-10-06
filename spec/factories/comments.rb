FactoryBot.define do
  factory :comment do
    user { nil }
    article { nil }
    body { Faker::Lorem.paragraph }
  end
end
