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

users = User.order(:created_at).take(6)
50.times do
  users.each { |user| user.works.create!(start_time: "start_time: Sat, 01 Jan 2000 18:31:00.000000000 UTC +00:00" ,
  end_time: "Sat, 01 Jan 2000 18:32:00.000000000 UTC +00:00", date: "Tue, 20 Feb 2024" ) }
end