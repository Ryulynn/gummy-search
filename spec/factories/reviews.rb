FactoryBot.define do
  factory :review do
    comment { "test_comment" }
    user { nil }
    gummy { nil }
  end
end
