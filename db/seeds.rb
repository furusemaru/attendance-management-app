require 'date'
# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

start_day = Date.new(2020, 1, 1)
end_day = Date.new(2024, 2, 20)

users = User.order(:created_at).take(1)
20.times do
  users.each { |user| user.works.create!(start_time: "09:00", end_time: "18:00", date: Random.rand(start_day..end_day) ) }
end