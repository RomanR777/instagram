FactoryBot.define do
  factory :post do
    user
    description { FFaker::Lorem.sentence }
    after(:create) { |object| object.photo.attach(io: File.open("./spec/cat.jpeg"), filename: "cat.jpeg") }
  end
end
