class GoalsController < ApplicationController
  before_action :set_user_id
  before_action :logged_in_user
  before_action :correct_user
  before_action :set_goal, only:[:show, :edit, :update, :destroy]

  def index
    @search_params = goal_search_params
    if @search_params.present?
      @goals = current_user.goals.search(@search_params).paginate(page: params[:page], per_page: 20).order(start_day: "DESC")
    else
      @goals = current_user.goals.paginate(page: params[:page], per_page: 20).order(start_day: "DESC")
    end
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
    redirect_to user_goals_url
  end

  # モーダル表示
  def goalgap_info
    @goal = Goal.find(params[:goal_id])
    @goalgaps = @goal.goalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  # ゴール検索
  def search
    @search_params = goal_search_params
    if current_user.goals.search(@search_params).count > 0
      @goals = current_user.goals.search(@search_params).order(start_day: "DESC")
      flash.now[:success] = "#{@goals.count}件ヒットしました。"
    else
      @goals = current_user.goals.paginate(page: params[:page], per_page: 20).order(start_day: "DESC")
      flash.now[:danger] = "該当するゴールはありませんでした。"
    end
    render :index
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

    # ゴール検索
    def goal_search_params
      params.fetch(:search, {}).permit(:goal, :start_day_from, :start_day_to, :progress, :hold)
      # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
      # ここでの:searchには、フォームから送られてくるparamsの値が入っている
    end

    # パラメーターからゴールを取得
    def set_goal
      @goal = Goal.find(params[:id])
    end
end
