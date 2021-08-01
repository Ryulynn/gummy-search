FactoryBot.define do
  factory :spot do
    address { "MyString" }
    shop { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
    user { nil }
    gummy { nil }
  end
end
