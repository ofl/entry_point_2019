FactoryBot.define do
  factory :article do
    user { nil }
    title { "MyString" }
    body { "MyText" }
  end
end
