FactoryBot.define do
  factory :post do
    action { Faker::Lorem.characters(number:20) }
    # user
    admin
  end
end
