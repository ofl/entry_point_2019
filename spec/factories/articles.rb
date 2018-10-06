FactoryBot.define do
  factory :article do
    user { nil }
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end
