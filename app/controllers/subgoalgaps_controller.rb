class SubgoalgapsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_subgoalgap, only:[:show, :edit, :update, :destroy]
  before_action :correct_user

  def index
    @search_params = subgoalgap_search_params
    if @search_params.present?
      @subgoalgaps = @subgoal.subgoalgaps.search(@search_params).paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    else
      @subgoalgaps = @subgoal.subgoalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    end
  end

  def show
  end

  def new
    @subgoalgap = Subgoalgap.new
  end

  def create
    @subgoalgap = @subgoal.subgoalgaps.build(subgoalgap_params)
    if @subgoalgap.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goal_subgoal_subgoalgaps_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @subgoalgap.update_attributes(subgoalgap_params)
      flash[:success] = "#{ @subgoalgap.gap }を編集しました。"
      redirect_to user_goal_subgoal_subgoalgaps_url
    else
      flash.now[:danger] = "#{ @subgoalgap.gap }を編集できませんでした。。"
      render :edit
    end
  end

  def destroy
    @subgoalgap.destroy
    flash[:success] = "#{ @subgoalgap.gap }を削除しました。"
    redirect_to user_goal_subgoal_subgoalgaps_url
  end

  # サブゴールギャップ検索
  def search
    @search_params = subgoalgap_search_params
    if @subgoal.subgoalgaps.search(@search_params).count > 0
      @subgoalgaps = @subgoal.subgoalgaps.search(@search_params).order(created_at: "DESC")
      flash.now[:success] = "#{ @subgoalgaps.count }件ヒットしました。"
    else
      @subgoalgaps = @subgoal.subgoalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
      flash.now[:danger] = "該当するサブゴールギャップはありませんでした。"
    end
    render :index
  end

  private
    # ストロングパラメーター
    def subgoalgap_params
      params.require(:subgoalgap).permit(:gap, :detail, :solution, :term, :impact, :worktime, :easy, :priority, :goal_id)
    end

    # サブゴールギャップ検索
    def subgoalgap_search_params
      params.fetch(:search, {}).permit(:gap, :impact, :worktime, :easy, :priority).merge(goal_id: @subgoal.goal_id, subgoal_id: @subgoal.id)
      # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
      # ここでの:searchには、フォームから送られてくるparamsの値が入っている
    end

    # paramsハッシュからsubgoalgapを取得
    def set_subgoalgap
      @subgoalgap = Subgoalgap.find(params[:id])
    end
end
