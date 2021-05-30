class SubgoalsController < ApplicationController
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal, only:[:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user
  

  def index
    @subgoals = current_user.subgoals.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  def new
    @subgoal = Subgoal.new
    @subgoalgap = @subgoal.subgoalgaps.build
  end

  def show
  end

  def create
    @subgoal = @goal.subgoals.build(create_subgoal_params)
    if @subgoal.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goal_subgoals_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @subgoal.update_attributes(edit_subgoal_params)
      flash[:success] = "「#{ @subgoal.subgoal }」の編集に成功しました。"
      redirect_to user_goal_subgoals_url
    else
      flash.now[:danger] = "「#{ @subgoal.subgoal }」の編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @subgoal.destroy
    flash[:success] = "「#{ @subgoal.subgoal }」を削除しました。"
    redirect_to user_goal_subgoals_url
  end

  private
    # ストロングパラメーター
    # 新規登録時 subgoalgapを同時に登録
    def create_subgoal_params
      params.require(:subgoal).permit(:subgoal, :start_day, :finish_day, :pattern, :priority, :impact, :worktime, :easy, :hold, :note, :goal_id, 
        subgoalgaps_attributes: [:id, :gap, :detail, :solution, :impact, :term, :worktime, :easy, :priority, :subgoal_id, :_destroy])
    end

    # 編集時
    def edit_subgoal_params
      params.require(:subgoal).permit(:subgoal, :start_day, :finish_day, :achivement, :check, :adjust,
        :pattern, :priority, :impact, :worktime, :easy, :progress, :hold, :note, doing_attributes:
        [
          :doing, :start_day, :finish_day, :achivement, :check, :adjust, :pattern, :priority, :impact, :worktime,
          :easy, :progress, :hold, :note, :_destroy, todo_attributes:
          [
            :todo, :start_day, :finish_day, :estimated_time, :estimated_start_time, :estimated_finish_time, :achivement,
            :actual_start_time, :actual_finish_time, :check, :adjust, :pattern, :progress, :hold, :note,  :_destroy
          ]
        ]
      )
    end

    # パラメーターから目標を取得
    def set_subgoal
      @subgoal = Subgoal.find(params[:id])
    end
end
