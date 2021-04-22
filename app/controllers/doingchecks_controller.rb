class DoingchecksController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_doing_id
  before_action :set_doingcheck, only:[:show, :edit, :update, :destroy]
  before_action :correct_user


  def index
    @doingchecks = @doing.doingchecks.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  def show
  end

  def new
    @doingcheck = Doingcheck.new
  end

  def create
    @doingcheck = @doing.doingchecks.build(doingcheck_params)
    if @doingcheck.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goal_subgoal_doing_doingchecks_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @doingcheck.update_attributes(doingcheck_params)
      flash[:success] = "「#{ l(@doingcheck.estimate_check_at, format: :long) }」を編集しました。"
      redirect_to user_goal_subgoal_doing_doingchecks_url
    else
      flash.now[:danger] = "「#{ l(@doingcheck.estimate_check_at, format: :long) }」を編集できませんでした。。"
      render :edit
    end
  end

  def destroy
    @doingcheck.destroy
    flash[:success] = "「#{ l(@doingcheck.estimate_check_at, format: :long) }」を削除しました。"
    redirect_to user_goal_subgoal_doing_doingchecks_url
  end

  private
    # ストロングパラメーター
    def doingcheck_params
      params.require(:doingcheck).permit(:check, :adjust, :estimate_check_at, :check_at, :span, 
        :achivement, :note, :doing_id)
    end

    # paramsハッシュからid取得
    def set_doingcheck
      @doingcheck = Doingcheck.find(params[:id])
    end

end
