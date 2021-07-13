class UsersController < ApplicationController
  before_action :limitation_login_user, only:[:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :show, :update]
  before_action :admin_or_correct_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page]).where.not(admin: true)
  end

  def show
    @todoes = Todo.where(user_id: @user.id).order(start_time: "ASC")
    beginning_of_day = DateTime.now.beginning_of_day
    end_of_day = DateTime.now.end_of_day
    @todoes_today = @todoes.where('start_time BETWEEN ? AND ?', beginning_of_day, end_of_day)
    # カレンダーのEvent
    @events = Event.where(user_id: @user.id)
    @event = Event.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image = "default.png" if params[:image].nil?
    if !verify_recaptcha(message: "reCAPTCHAのチェックをしてください。")
      render :new 
    elsif @user.save
      log_in @user # 保存成功後、ログインする
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    @user.image = "default.png" if params[:image].nil?
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{ @user.name }さんのデータを削除しました。"
    if current_user.admin?
      redirect_to users_url
    else
      redirect_to root_url
    end
  end

  # フォロー
  def following
    @title = "フォロー"
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  # フォロワー
  def followers
    @title = "フォロワー"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  # ユーザー検索
  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%").paginate(page: params[:page], per_page: 20 )
      if @users.count > 0
        flash.now[:success] = "#{ @users.count }件ヒットしました。" 
      else
        @users = User.paginate(page: params[:page], per_page: 20 )
        flash.now[:danger] = "該当ユーザーはいませんでした。"
      end
    else
      @users = User.paginate(page: params[:page], per_page: 20 )
      flash.now[:danger] = "該当ユーザーはいませんでした。"
    end
    render :index
  end

  private
    # ストロングパラメーター
    def user_params
      params.require(:user).permit(:name, :email, :image, :introduction, :password, :password_confirmation, :agreement)
    end

end
