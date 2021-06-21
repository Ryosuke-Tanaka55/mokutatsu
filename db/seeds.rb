# coding: utf-8

User.create!(name: "管理者",
  email: "sample@email.com",
  password: "password",
  password_confirmation: "password",
  agreement: true,
  admin: true)

60.times do |n|
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