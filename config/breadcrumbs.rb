crumb :root do
  link "トップページ", root_path
end

# session
crumb :session_new do
  link "ログイン", login_path
  parent :root
end

# 利用規約、プライバシーポリシー
crumb :rule do
  link "利用規約", rule_path
  parent :root
end

crumb :policy do
  link "プライバシーポリシー", policy_path
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
  link "#{ current_user.name }さんのゴール一覧", user_goals_path(current_user)
  parent :user_show, current_user
end

crumb :goal_new do
  link "ゴール登録", new_user_goal_path(current_user)
  parent :goal_index, current_user
end

crumb :goal_show do |goal|
  link "ゴール詳細", user_goal_path(goal)
  parent :goal_index, current_user
end

crumb :goal_edit do |goal|
  link "ゴール編集", edit_user_goal_path(goal)
  parent :goal_index, current_user
end

# ゴールギャップ
crumb :goalgap_index do |goal|
  link "ゴールギャップ一覧", user_goal_goalgaps_path(goal)
  parent :goal_index, current_user
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

# サブゴール
crumb :subgoal_index do |goal|
  link "サブゴール一覧", user_goal_subgoals_path(goal)
  parent :goal_index, current_user, goal.id
end

crumb :subgoal_new do |goal|
  link "サブゴール登録", new_user_goal_subgoal_path(goal)
  parent :subgoal_index, current_user, goal.id
end

crumb :subgoal_show do |subgoal|
  link "サブゴール詳細", user_goal_subgoal_path(subgoal)
  parent :subgoal_index, current_user, subgoal.goal_id
end

crumb :subgoal_edit do |subgoal|
  link "サブゴール編集", edit_user_goal_subgoal_path(subgoal)
  parent :subgoal_index, current_user, subgoal.goal_id
end

# サブゴールギャップ
crumb :subgoalgap_index do |subgoal|
  link "サブゴールギャップ一覧", user_goal_subgoal_subgoalgaps_path(subgoal)
  parent :subgoal_index, current_user, subgoal.id
end

crumb :subgoalgap_new do |subgoal|
  link "サブゴールギャップ登録", new_user_goal_subgoal_subgoalgap_path(subgoal)
  parent :subgoalgap_index, current_user, subgoal.id
end

crumb :subgoalgap_show do |subgoalgap|
  link "サブゴールギャップ詳細", user_goal_subgoal_subgoalgap_path(subgoalgap)
  parent :subgoalgap_index, current_user, subgoalgap.id
end

crumb :subgoalgap_edit do |subgoalgap|
  link "サブゴールギャップ編集", edit_user_goal_subgoal_subgoalgap_path(subgoalgap)
  parent :subgoalgap_index, current_user, subgoalgap.id
end

# サブゴール検証
crumb :subgoalcheck_index do |subgoal|
  link "サブゴール検証一覧", user_goal_subgoal_subgoalchecks_path(subgoal)
  parent :subgoal_index, current_user, subgoal.id
end

crumb :subgoalcheck_new do |subgoal|
  link "サブゴール検証登録", new_user_goal_subgoal_subgoalcheck_path(subgoal)
  parent :subgoalcheck_index, current_user, subgoal.id
end

crumb :subgoalcheck_show do |subgoalcheck|
  link "サブゴール検証詳細", user_goal_subgoal_subgoalcheck_path(subgoalcheck)
  parent :subgoalcheck_index, current_user, subgoalcheck.id
end

crumb :subgoalcheck_edit do |subgoalcheck|
  link "サブゴール検証編集", user_goal_subgoal_subgoalcheck_path(subgoalcheck)
  parent :subgoalcheck_index, current_user, subgoalcheck.id
end

# Do
crumb :doing_index do |subgoal|
  link "Do一覧", user_goal_subgoal_doings_path(subgoal)
  parent :subgoal_index, current_user, subgoal.id
end

crumb :doing_new do |subgoal|
  link "Do登録", new_user_goal_subgoal_doing_path(subgoal)
  parent :doing_index, current_user, subgoal.id
end

crumb :doing_show do |doing|
  link "Do詳細", user_goal_subgoal_doing_path(doing)
  parent :doing_index, current_user, doing.id
end

crumb :doing_edit do |doing|
  link "Do編集", edit_user_goal_subgoal_doing_path(doing)
  parent :doing_index, current_user, doing.id
end

# Do検証
crumb :doingcheck_index do |doing|
  link "Do検証一覧", user_goal_subgoal_doing_doingchecks_path(doing)
  parent :doing_index, current_user, doing.id
end

crumb :doingcheck_new do |doing|
  link "Do検証登録", new_user_goal_subgoal_doing_doingcheck_path(doing)
  parent :doingcheck_index, current_user, doing.id
end

crumb :doingcheck_show do |doingcheck|
  link "Do検証詳細", user_goal_subgoal_doing_doingcheck_path(doingcheck)
  parent :doingcheck_index, current_user, doingcheck.id
end

crumb :doingcheck_edit do |doingcheck|
  link "Do検証編集", user_goal_subgoal_doing_doingcheck_path(doingcheck)
  parent :doingcheck_index, current_user, doingcheck.id
end

# ToDo検証
crumb :todo_index do |doing|
  link "ToDo一覧", user_goal_subgoal_doing_todoes_path(doing)
  parent :doing_index, current_user, doing.id
end

crumb :todo_new do |doing|
  link "ToDo登録", new_user_goal_subgoal_doing_todo_path(doing)
  parent :todo_index, current_user, doing.id
end

crumb :todo_show do |todo|
  link "ToDo詳細", user_goal_subgoal_doing_todo_path(todo)
  parent :todo_index, current_user, todo.id
end

crumb :todo_edit do |todo|
  link "ToDo編集", edit_user_goal_subgoal_doing_todo_path(todo)
  parent :todo_index, current_user, todo.id
end