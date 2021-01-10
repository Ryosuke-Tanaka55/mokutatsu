class SubgoalsController < ApplicationController
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal, only:[:show, :edit, :update, :destroy]
  before_action :loggend_in_user
  before_action :correct_user
  

  def index
    @subgoals = current_user.subgoals.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  def show
  end

  def new
    @subgoal = Subgoal.new
  end

  def create
    @subgoal = @goal.subgoals.build(create_subgoal_params)
    if @subgoal.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goals_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @subgoal.update_attributes(edit_subgoal_params)
      flash[:success] = "編集に成功しました。"
      redirect_to subgoals_url
    else
      flash.now[:danger] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @subgoal.destroy
    flash[:success] = "サブゴールを削除しました。"
    redirect_to subgoals_url
  end

  private
    # ストロングパラメーター
    # 新規登録時
    def create_subgoal_params
      params.require(:subgoal).permit(:subgoal, :start_day, :finish_day, :pattern, 
        :priority, :impact, :worktime, :easy, :hold, :note, :goal_id)
    end

    # 編集時
    def edit_subgoal_params
      params.require(:subgoal).permit(:subgoal, :start_day, :finish_day, :achivement, :check, :adjust,
        :pattern, :priority, :impact, :worktime, :easy, :progress, :hold, :note, doing_attributes:
        [
          :doing, :start_day, :finish_day, :achivement, :check, :adjust, :pattern, :priority, :impact, :worktime,
          :easy, :progress, :hold, :note, todo_attributes:
          [
            :todo, :start_day, :finish_day, :estimated_time, :estimated_start_time, :estimated_finish_time, :achivement,
            :actual_start_time, :actual_finish_time, :check, :adjust, :pattern, :progress, :hold, :note
          ]
        ]
      )
    end

    # パラメーターから目標を取得
    def set_subgoal
      @subgoal = Subgoal.find(params[:id])
    end
end
