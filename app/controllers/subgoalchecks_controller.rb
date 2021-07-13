class SubgoalchecksController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_subgoalcheck, only:[:show, :edit, :update, :destroy]
  before_action :correct_user

  def index
    @search_params = subgoalcheck_search_params
    if @search_params.present?
      @subgoalchecks = @subgoal.subgoalchecks.search(@search_params).paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    else
      @subgoalchecks = @subgoal.subgoalchecks.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    end
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

  # サブゴール検証検索
  def search
    @search_params = subgoalcheck_search_params
    if @subgoal.subgoalchecks.search(@search_params).count > 0
      @subgoalchecks = @subgoal.subgoalchecks.search(@search_params).order(created_at: "DESC")
      flash.now[:success] = "#{ @subgoalchecks.count }件ヒットしました。"
    else
      @subgoalchecks = @subgoal.subgoalchecks.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
      flash.now[:danger] = "該当するサブゴール検証はありませんでした。"
    end
    render :index
  end

  private
    # ストロングパラメーター
    def subgoalcheck_params
      params.require(:subgoalcheck).permit(:check, :adjust, :estimate_check_at, :check_at, :span, 
        :achivement, :note, :subgoal_id)
    end

    # サブゴール検証検索
    def subgoalcheck_search_params
      params.fetch(:search, {}).permit(:estimate_check_at_from, :estimate_check_at_to, :check_at_from, 
        :check_at_from, :check_at_to).merge(goal_id: @subgoal.goal_id, subgoal_id: @subgoal.id )
      # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
      # ここでの:searchには、フォームから送られてくるparamsの値が入っている
    end

    # paramsハッシュからid取得
    def set_subgoalcheck
      @subgoalcheck = Subgoalcheck.find(params[:id])
    end
end
