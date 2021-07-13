class SubgoalsController < ApplicationController
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal, only:[:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user
  
  def index
    @search_params = subgoal_search_params
    if @search_params.present?
      @subgoals = @goal.subgoals.search(@search_params).paginate(page: params[:page], per_page: 20).order(start_day: "DESC")
    else
      @subgoals = @goal.subgoals.paginate(page: params[:page], per_page: 20).order(start_day: "DESC")
    end
  end

  def new
    @subgoal = Subgoal.new
    @subgoalgap = @subgoal.subgoalgaps.build
    @goalgaps = current_user.goalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
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
    @goalgaps = current_user.goalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
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

  # モーダル表示
  def subgoalgap_info
    @subgoal = @goal.subgoals.find(params[:subgoal_id])
    @subgoalgaps = @subgoal.subgoalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  # サブゴール検索
  def search
    @search_params = subgoal_search_params
    if @goal.subgoals.search(@search_params).count > 0
      @subgoals = @goal.subgoals.search(@search_params).order(start_day: "DESC")
      flash.now[:success] = "#{ @subgoals.count }件ヒットしました。"
    else
      @subgoals = @goal.subgoals.paginate(page: params[:page], per_page: 20).order(start_day: "DESC")
      flash.now[:danger] = "該当するサブゴールはありませんでした。"
    end
    render :index
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
      params.require(:subgoal).permit(:subgoal, :start_day, :finish_day, :pattern, :priority, :impact, 
        :worktime, :easy, :progress, :hold, :note)
    end

    # サブゴール検索
    def subgoal_search_params
      params.fetch(:search, {}).permit(:subgoal, :important, :start_day_from, :start_day_to, :priority, :hold).merge(goal_id: @goal.id)
      # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
      # ここでの:searchには、フォームから送られてくるparamsの値が入っている
    end

    # パラメーターから目標を取得
    def set_subgoal
      @subgoal = Subgoal.find(params[:id])
    end
end
