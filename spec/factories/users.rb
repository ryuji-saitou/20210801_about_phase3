FactoryBot.define do
  factory :user do
    user_name { "password@password" }
    user_name_id { "password@password" }
    email { Faker::Internet.email}
    birthday { 1989-01-03 }
    is_deleted { "false" }
    password { "password" }
    password_confirmation { "password" }
  end
end
