FactoryBot.define do
  factory :user do
    nickname { "___#{FFaker::Internet.user_name}___" }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
