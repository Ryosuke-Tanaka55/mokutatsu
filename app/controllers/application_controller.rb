class ApplicationController < ActionController::Base
  # sessions_helper、PostsHelperを全てのコントローラーで使えるようにする
  protect_from_forgery with: :exception
  include SessionsHelper
  include PostsHelper

  # beforeフィルター
  
  # paramsハッシュからユーザーを取得
  def set_user
    @user = User.find(params[:id])
  end

  # paramsハッシュ(user_id)からユーザーを取得
  def set_user_id
    @user = User.find(params[:user_id])
  end

  # ログイン済みのユーザーか確認
  def logged_in_user
    unless logged_in?
      store_location # sessions_helper参照
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end

  # ログインユーザーを制限する
  def limitation_login_user
    if @current_user
      flash[:notice] = "すでにログイン状態です。"
      redirect_to root_url
    end
  end

  # アクセスしたユーザーが現在ログインしているユーザーか確認
  def correct_user
    unless current_user?(@user)
      flash[:danger] = "他のユーザー情報は閲覧出来ません。"
      redirect_to root_url
    end
  end

  # システム管理権限所有かどうか判定
  def admin_user
    unless current_user.admin?
      flash[:danger] = "管理者権限がありません。"
      redirect_to root_url
    end
  end

  # システム管理者を除外
  def not_admin_user
    if current_user.admin?
      flash[:danger] = "管理者は利用できません。"
      redirect_to root_url
    end
  end

  # システム管理者かアクセスしたユーザーが現在ログインしているユーザーか判定
  def admin_or_correct_user
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "他のユーザー情報は操作できません。"
      redirect_to root_url
    end
  end

  # paramsからゴール(goal_id)を取得
  def set_goal_id
    @goal = Goal.find(params[:goal_id])
  end

  # paramsからサブゴール(subgoal_id)を取得
  def set_subgoal_id
    @subgoal = Subgoal.find(params[:subgoal_id])
  end

  # paramsからDo(doing_id)を取得
  def set_doing_id
    @doing = Doing.find(params[:doing_id])
  end

end
