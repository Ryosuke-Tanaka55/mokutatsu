class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン後にユーザー情報ページにリダイレクトする
      log_in user # 引数で渡されたユーザーオブジェクトでログイン（sessionshelper参照）
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user # sessions_helper参照
    else
      flash.now[:danger] = "認証に失敗しました。"
      render :new
    end 
  end

  def destroy
    # ログイン中の場合のみログアウト処理を行う
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
