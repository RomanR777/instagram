FactoryBot.define do
  factory :post do
    user
    description { FFaker::Lorem.sentence }
  end
end
