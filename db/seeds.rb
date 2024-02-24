require 'date'
require 'faker'

# メインのサンプルユーザーを1人作成する
User.create!(name:  "古瀬 佑太",
             email: "example@sample.org",
             password:              "foobar",
             password_confirmation: "foobar")

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@sample.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

start_day = Date.new(2020, 1, 1)
end_day = Date.new(2024, 2, 20)

users = User.order(:created_at).take(10)
200.times do
  users.each do |user|
    # 重複しないランダムな日付を生成する
    random_date = Random.rand(start_day..end_day)
    
    # すでに同じ日付の勤怠が存在する場合はやり直す
    while user.works.exists?(date: random_date)
      random_date = Random.rand(start_day..end_day)
    end

    user.works.create!(start_time: "09:00", end_time: "18:00", date: random_date)
  end
end


users = User.order(:created_at).take(30)
users.each do |user|
  5.times do |n|
    user.works.create!(start_time: "09:00", end_time: "18:00", date: Date.new(2024, 2, 21+n))
  end
end



User.create!(name:  "管理 有座",
             email: "admin@admin.org",
             password:              "password",
             password_confirmation: "password",
             admin: true)