class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン後にユーザー情報ページにリダイレクトする
      log_in user # 引数で渡されたユーザーオブジェクトでログイン（sessionshelper参照）
      redirect_to user
    else
      flash.now[:danger] = "認証に失敗しました。"
      render :new
    end 
  end
end
