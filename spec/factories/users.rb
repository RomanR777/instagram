FactoryBot.define do
  factory :user do
    id { 1 }
    nickname { "user1" }
    email { "user1@user1.com" }
    password { "1q2w3e4r" }
  end
end
