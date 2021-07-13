class GoalchecksController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_goalcheck, only:[:show, :edit, :update, :destroy]
  before_action :correct_user


  def index
    @search_params = goalcheck_search_params
    if @search_params.present?
      @goalchecks = @goal.goalchecks.search(@search_params).paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    else
      @goalchecks = @goal.goalchecks.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    end
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

  # ゴール検証検索
  def search
    @search_params = goalcheck_search_params
    if @goal.goalchecks.search(@search_params).count > 0
      @goalchecks = @goal.goalchecks.search(@search_params).order(created_at: "DESC")
      flash.now[:success] = "#{ @goalchecks.count }件ヒットしました。"
    else
      @goalchecks = @goal.goalchecks.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
      flash.now[:danger] = "該当するゴール検証はありませんでした。"
    end
    render :index
  end

  private
    # ストロングパラメーター
    def goalcheck_params
      params.require(:goalcheck).permit(:check, :adjust, :estimate_check_at, :check_at, :span, 
        :achivement, :note, :goal_id)
    end

    def goalcheck_search_params
      params.fetch(:search, {}).permit(:estimate_check_at_from, :estimate_check_at_to, :check_at_from, :check_at_from, :check_at_to).merge(goal_id: @goal.id)
      # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
      # ここでの:searchには、フォームから送られてくるparamsの値が入っている
    end

    # paramsハッシュからid取得
    def set_goalcheck
      @goalcheck = Goalcheck.find(params[:id])
    end

end
