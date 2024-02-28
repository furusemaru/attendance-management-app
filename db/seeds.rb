require 'date'
require 'faker'

def generate_weekday_dates(start_date, end_date)
  weekdays = (start_date..end_date).to_a.select { |d| (1..5).include?(d.wday) } # 1~5が平日
end

def generate_holiday_dates(start_date, end_date)
  weekdays = (start_date..end_date).to_a.select { |d| [0,6].include?(d.wday) } # 0,6が休日
end

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

start_day = Date.new(2023, 12, 1)
end_day = Date.new(2024, 3, 15)
start_time_sample = ["07:00","08:00","08:00","09:00","09:00","09:00","09:00","10:00","11:00"]
end_time_sample = ["17:00","17:00","18:00","18:00","18:00","18:00","18:00","18:00","19:00","20:00","21:00","21:00","22:00"]
break_time_sample = ["01:00","01:00","01:00","01:00","01:00","01:00","01:00","01:00","00:50","01:30","00:45"]
location_sample = ['出社', 'リモート']
comment_sample = [nil, nil, nil, nil, nil, nil, nil, nil,'テストコメント'] #時たまコメントあり
users = User.all

#平日のデータを追加
users.each do |user|
  weekdays = generate_weekday_dates(start_day, end_day)
  while weekdays.length > 15 do
    date = weekdays.slice!(rand(weekdays.size))
    user.works.create!(start_time: start_time_sample.sample,
    end_time: end_time_sample.sample, date: date,
    break_time: break_time_sample.sample,
    location: location_sample.sample,
    comment: comment_sample.sample)
  end
end

#休日のデータを追加
users.each do |user|
  holidays = generate_holiday_dates(start_day, end_day)
  4.times do
    date = holidays.slice!(rand(holidays.size))
    user.works.create!(start_time: start_time_sample.sample,
    end_time: end_time_sample.sample, date: date,
    break_time: break_time_sample.sample,
    location: location_sample.sample,
    comment: comment_sample.sample)
  end
end



  




