require 'date'
require 'faker'

# メインのサンプルユーザーを1人作成する
User.create!(first_name:  "佑太",
             last_name: "古瀬",
             department: "総務",
             email: "example@sample.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
  last_name, first_name = Faker:: Name.name.split(" ")
  department = ["営業", "開発", "人事", "総務"].sample
  email = "example-#{n+1}@sample.org"
  password = "password"
  User.create!(first_name: first_name,
               last_name: last_name,
               department: department,
               email: email,
               password:              password,
               password_confirmation: password)
end

start_day = Date.new(2022, 1, 1)
end_day = Date.new(2024, 2, 20)
start_time_sample = ["07:00","08:00","08:00","09:00","09:00","09:00","09:00","10:00","11:00"]
end_time_sample = ["17:00","17:00","18:00","18:00","18:00","18:00","18:00","18:00","19:00","20:00","21:00","21:00","22:00"]
break_time_sample = ["01:00","01:00","01:00","01:00","01:00","01:00","01:00","01:00","00:50","01:30","00:45"]
location_sample = ['出社', 'リモート']
users = User.order(:created_at).take(30)
200.times do
  users.each do |user|
    # 重複しないランダムな日付を生成する
    random_date = Random.rand(start_day..end_day)
    
    # すでに同じ日付の勤怠が存在する場合はやり直す
    while user.works.exists?(date: random_date)
      random_date = Random.rand(start_day..end_day)
    end

    user.works.create!(start_time: start_time_sample.sample, end_time: end_time_sample.sample, date: random_date, break_time: break_time_sample.sample, location: location_sample.sample)
  end
end


users = User.order(:created_at).take(30)
users.each do |user|
  5.times do |n|
    user.works.create!(start_time: start_time_sample.sample, end_time: end_time_sample.sample, date: Date.new(2024, 2, 21+n), break_time: break_time_sample.sample, location: location_sample.sample)
  end
end


