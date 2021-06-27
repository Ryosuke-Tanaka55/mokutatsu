crumb :root do
  link "トップページ", root_path
end

# session
crumb :session_new do
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

crumb :user_index do |user|
  link "ユーザー一覧", users_path
  parent :user_show, user
end

crumb :user_edit do |user|
  link "ユーザー編集"
  parent :user_show, user
end

# 投稿
crumb :post_index do
  link "全体の投稿", user_posts_path(current_user)
  parent :user_show, current_user
end

crumb :post_show_own_post do |user|
  link "#{ user.name }さんの投稿ページ", posts_show_own_post_user_path(user)
  parent :post_index, current_user
end

crumb :post_show do |post|
  link "#{ post.user.name }さんの投稿詳細"
  parent :post_show_own_post, post.user
end

# フォロー、フォロワー
crumb :user_follow do |user|
  if controller.action_name == "following"
    link "#{ user.name }さんのフォロー"
  else
    link "#{ user.name }さんのフォロワー"
  end
  parent :post_show_own_post, user
end

# ゴール
crumb :goal_index do
  link "#{ current_user.name }のゴール一覧", user_goals_path(current_user)
  parent :user_show, current_user
end

crumb :goal_new do
  link "ゴール登録", new_user_goal_path(current_user)
  parent :goal_index, current_user
end

crumb :goal_show do |goal|
  link "ゴール詳細", user_goals_path(goal)
  parent :goal_index, current_user
end

crumb :goal_edit do |goal|
  link "ゴール編集", edit_user_goal_path(goal)
  parent :goal_index, current_user
end

# ゴールギャップ
crumb :goalgap_index do |goal|
  link "ゴールギャップ一覧", user_goal_goalgaps_path(goal)
  parent :goal_show, current_user, goal
end

crumb :goalgap_new do |goal|
  link "ゴールギャップ登録", new_user_goal_goalgap_path(goal)
  parent :goalgap_index, goal.user_id
end

crumb :goalgap_show do |goal|
  link "ゴールギャップ詳細", user_goal_goalgap_path(goal)
  parent :goalgap_index, goal.user_id, goal.id
end

crumb :goalgap_edit do |goal|
  link "ゴールギャップ編集", edit_user_goal_goalgap_path(goal)
  parent :goalgap_index, goal.user_id
end

# ゴール検証
crumb :goalcheck_index do |goal|
  link "ゴール検証一覧", user_goal_goalchecks_path(goal)
  parent :goal_index, current_user, goal.id
end

crumb :goalcheck_new do |goal|
  link "ゴール検証登録", new_user_goal_goalcheck_path(goal)
  parent :goalcheck_index, current_user, goal.id
end

crumb :goalcheck_show do |goal|
  link "ゴール検証詳細", user_goal_goalcheck_path(goal)
  parent :goalcheck_index, current_user, goal.id
end

crumb :goalcheck_edit do |goal|
  link "ゴール検証編集", edit_user_goal_goalcheck_path(goal)
  parent :goalcheck_index, current_user, goal.id
end