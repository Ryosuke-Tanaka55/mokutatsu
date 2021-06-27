crumb :root do
  link "トップページ", root_path
end

# session
crumb :user_new do
  link "ログイン", login_path
  parent :root
end

# ユーザー
crumb :user_new do
  link "ユーザー登録", new_user_path
  parent :root
end

crumb :user_show do |user|
  link "マイページ", user_path(user)
  parent :root
end

crumb :user_edit do |user|
  link "ユーザー編集"
  parent :user_show, user
end