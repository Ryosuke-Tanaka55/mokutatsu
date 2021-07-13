# coding: utf-8

User.create!(name: "管理者",
  email: "sample@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true,
  admin: true)

User.create!(name: "福田 周平",
  email: "fukuda@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)

User.create!(name: "宗 佑真",
  email: "mune@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)

User.create!(name: "吉田 正尚",
  email: "yoshida@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)

User.create!(name: "杉本 祐太郎(ラオウ)",
  email: "sugimoto@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)

User.create!(name: "T-岡田",
  email: "t-okada@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)

User.create!(name: "安達 了一",
  email: "adachi@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)

User.create!(name: "スティーブン・モヤ",
  email: "moya@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)

User.create!(name: "紅林 幸太郎",
  email: "kurebayashi@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)

User.create!(name: "若月 健矢",
  email: "wakatsuki@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)

User.create!(name: "宮城 大弥",
  email: "miyagi@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true)
  
10.times do |n|
name  = Faker::Name.name
email = "sample-#{n+1}@email.com"
password = "password"
User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    agreement: true)
end

# 以下のリレーションシップを作成する
users = User.all
user  = users.second
following = users[3..50]
followers = users[4..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }