FactoryBot.define do
  factory :spot do
    address { "test_address" }
    shop { "test_shop" }
    latitude { 1.5 }
    longitude { 1.5 }
    user { nil }
    gummy { nil }
  end
end
