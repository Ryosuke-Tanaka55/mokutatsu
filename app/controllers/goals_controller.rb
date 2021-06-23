class GoalsController < ApplicationController
  before_action :set_user_id
  before_action :logged_in_user
  before_action :correct_user
  before_action :set_goal, only:[:show, :edit, :update, :destroy]

  def index
    @goals = current_user.goals.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  def show
  end

  def new
    @goal = Goal.new
    @goalgaps = @goal.goalgaps.build
  end

  def create
    @goal = current_user.goals.build(create_goal_params)
    if @goal.save
      flash[:success] = "ゴールの新規作成に成功しました。"
      redirect_to user_goals_url
    else
      flash.now[:danger] = "ゴールの新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @goal.update_attributes(edit_goal_params)
      flash[:success] = "「#{ @goal.goal }」を編集しました。"
      redirect_to user_goals_path
    else
      flash.now[:danger] = "「#{ @goal.goal }」の編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @goal.destroy
    flash[:success] = "「#{ @goal.goal }」を削除しました。"
    redirect_to goals_url
  end

  private
    # ストロングパラメーター
    # 新規ゴール登録時 goalgapを同時に登録
    def create_goal_params
      params.require(:goal).permit(:goal, :category, :start_day, :finish_day, :goal_index, :hold, :note, 
        goalgaps_attributes: [:id, :gap, :detail, :solution, :impact, :worktime, :easy, :priority, :goal_id, :_destroy])
    end

    # 編集時
    def edit_goal_params
      params.require(:goal).permit(:goal, :category, :start_day, :finish_day, :progress, :goal_index, :hold, :note)
    end

    # パラメーターからゴールを取得
    def set_goal
      @goal = Goal.find(params[:id])
    end
end
