FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "tname#{n}" } # "test_name#{n}"とすると、UserModelのvalidationの最大文字数に抵触する
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    image { "default_user_icon.jpg" }
    admin { false }
  end
end
