class SubgoalchecksController < ApplicationController
  before_action :loggend_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_subgoalcheck, only:[:show, :edit, :update, :destroy]
  before_action :correct_user


  def index
    @subgoalchecks = @subgoal.subgoalchecks.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  def show
  end

  def new
    @subgoalcheck = Subgoalcheck.new
  end

  def create
    @subgoalcheck = @subgoal.subgoalchecks.build(subgoalcheck_params)
    if @subgoalcheck.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goal_subgoal_subgoalchecks_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @subgoalcheck.update_attributes(subgoalcheck_params)
      flash[:success] = "「#{ l(@subgoalcheck.estimate_check_at, format: :long) }」を編集しました。"
      redirect_to user_goal_subgoal_subgoalchecks_url
    else
      flash.now[:danger] = "「#{ l(@subgoalcheck.estimate_check_at, format: :long) }」を編集できませんでした。。"
      render :edit
    end
  end

  def destroy
    @subgoalcheck.destroy
    flash[:success] = "「#{ l(@subgoalcheck.estimate_check_at, format: :long) }」を削除しました。"
    redirect_to user_goal_subgoal_subgoalchecks_url
  end

  private
    # ストロングパラメーター
    def subgoalcheck_params
      params.require(:subgoalcheck).permit(:check, :adjust, :estimate_check_at, :check_at, :span, 
        :achivement, :note, :subgoal_id)
    end

    # paramsハッシュからid取得
    def set_subgoalcheck
      @subgoalcheck = Subgoalcheck.find(params[:id])
    end
end
