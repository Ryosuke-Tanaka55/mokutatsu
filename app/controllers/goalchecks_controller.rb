class GoalchecksController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_goalcheck, only:[:show, :edit, :update, :destroy]
  before_action :correct_user


  def index
    @goalchecks = @goal.goalchecks.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  def show
  end

  def new
    @goalcheck = Goalcheck.new
  end

  def create
    @goalcheck = @goal.goalchecks.build(goalcheck_params)
    if @goalcheck.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goal_goalchecks_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @goalcheck.update_attributes(goalcheck_params)
      flash[:success] = "「#{ l(@goalcheck.estimate_check_at, format: :long) }」を編集しました。"
      redirect_to user_goal_goalchecks_url
    else
      flash.now[:danger] = "「#{ l(@goalcheck.estimate_check_at, format: :long) }」を編集できませんでした。。"
      render :edit
    end
  end

  def destroy
    @goalcheck.destroy
    flash[:success] = "「#{ l(@goalcheck.estimate_check_at, format: :long) }」を削除しました。"
    redirect_to user_goal_goalchecks_url
  end

  private
    # ストロングパラメーター
    def goalcheck_params
      params.require(:goalcheck).permit(:check, :adjust, :estimate_check_at, :check_at, :span, 
        :achivement, :note, :goal_id)
    end

    # paramsハッシュからid取得
    def set_goalcheck
      @goalcheck = Goalcheck.find(params[:id])
    end

end
