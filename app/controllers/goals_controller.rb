class GoalsController < ApplicationController
  before_action :set_user
  before_action :loggend_in_user
  before_action :set_goal, only:[:edit, :update, :destroy]

  def index
    @goals = current_user.goals.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(create_goal_params)
    if @goal.save
      flash[:success] = "目標の新規作成に成功しました。"
      redirect_to goals_url
    else
      flash.now[:danger] = "目標の新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    @goals = Goal.where(user_id: current_user.id)
    if @goal.update_attributes(edit_goal_params)
      flash[:success] = "目標を編集しました。"
      redirect_to @user
    else
      flash.now[:danger] = "目標編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    goal = Goal.find(params[:id])
    goal.destroy
    flash[:success] = "目標を削除しました。"
    redirect_to @user
  end

  private
    # ストロングパラメーター
    # 新規目標設定時
    def create_goal_params
      params.require(:goal).permit(:goal, :tag, :start_day, :finish_day, :goal_index, :hold, :publish, :note, :user_id)
    end

    # 編集時
    def edit_goal_params
      params.require(:goal).permit(:goal, :tag, :start_day, :finish_day, :progress, :goal_index, :achivement, 
        :check, :adjust, :hold, :publish, :note, :user_id, :subgoal_id)
    end

    # パラメーターから目標を取得
    def set_goal
      @goal = Goal.find(params[:id])
    end
end
