FactoryBot.define do
  factory :gummy do
    sequence(:name) { |n| "test_gummy_#{n}" }
    image { "test_gummy_image.jpg" }
    flavor_id_1 { 1 }
    flavor_id_2 { nil }
    flavor_id_3 { nil }
    flavor_id_4 { nil }
  end
end
