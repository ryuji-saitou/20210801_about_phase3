# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ==============================================================
# ==="rails db:seed" 前に必ず "rails db:migrate:reset"==========
# ==============================================================

# ▼Adminテーブル作成
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# ▼Userテーブル作成
5.times do |number|
  User.create!(
    user_name: "seed_test@test#{number + 1}",
    user_name_id: "seed_test@test#{number + 1}",
    birthday: "1989-01-01",
    email: "seed_test@test#{number + 1}",
    password: "seed_test@test#{number + 1}",
    is_deleted: "false"
  )
end

# ▼Postテーブル作成
User.all.each do |user|
  3.times do |number|
    Post.create!(
      user_id: "#{number + 1}",
      action: "action_#{number + 1}",
      time_required: "#{number + 1}",
      budget: "#{number + 1}",
      is_hided: "false"
    )
  end
end