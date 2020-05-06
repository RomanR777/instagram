FactoryBot.define do
  factory :post do
    user
    description { "The description" }
  end

  factory :like do
    user_id { 1 }
    post_id { 2 }
  end
end
