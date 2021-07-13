class SessionsController < ApplicationController
  before_action :limitation_login_user

  def new
  end

  def create
    # Google認証
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.from_omniauth(request.env['omniauth.auth'])
      if user.save
        session[:user_id] = user.id
        flash[:success] = "ユーザー認証に成功しました。"
        redirect_back_or user
      else
        flash[:danger] = "ユーザー認証に失敗しました。"
        redirect_to login_url
      end
    # パスワード認証
    elsif !verify_recaptcha(message: "reCAPTCHAのチェックをしてください。")
      render :new
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        # ログイン後にユーザー情報ページにリダイレクトする
        log_in user # 引数で渡されたユーザーオブジェクトでログイン（sessionshelper参照）
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "ユーザー認証に成功しました。"
        redirect_back_or user # sessions_helper参照
      else
        flash.now[:danger] = "ユーザー認証に失敗しました。"
        render :new
      end
    end
  end

  def destroy
    # ログイン中の場合のみログアウト処理を行う
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end

    private
    # reCAPTHがチェックされているか判定
    def check_captcha
      unless verify_recaptcha(message: "reCAPTCHAのチェックをしてください。")
        redirect_to login_url
      end
    end
end
