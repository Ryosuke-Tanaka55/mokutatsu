class DoingchecksController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_doing_id
  before_action :set_doingcheck, only:[:show, :edit, :update, :destroy]
  before_action :correct_user


  def index
    @search_params = doingcheck_search_params
    if @search_params.present?
      @doingchecks = @doing.doingchecks.search(@search_params).paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    else
      @doingchecks = @doing.doingchecks.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    end
  end

  def show
  end

  def new
    @doingcheck = Doingcheck.new
  end

  def create
    @doingcheck = @doing.doingchecks.build(doingcheck_params)
    if @doingcheck.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goal_subgoal_doing_doingchecks_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @doingcheck.update_attributes(doingcheck_params)
      flash[:success] = "「#{ l(@doingcheck.estimate_check_at, format: :long) }」を編集しました。"
      redirect_to user_goal_subgoal_doing_doingchecks_url
    else
      flash.now[:danger] = "「#{ l(@doingcheck.estimate_check_at, format: :long) }」を編集できませんでした。。"
      render :edit
    end
  end

  def destroy
    @doingcheck.destroy
    flash[:success] = "「#{ l(@doingcheck.estimate_check_at, format: :long) }」を削除しました。"
    redirect_to user_goal_subgoal_doing_doingchecks_url
  end

  # Do検証検索
  def search
    @search_params = doingcheck_search_params
    if @doing.doingchecks.search(@search_params).count > 0
      @doingchecks = @doing.doingchecks.search(@search_params).order(created_at: "DESC")
      flash.now[:success] = "#{ @doingchecks.count }件ヒットしました。"
    else
      @doingchecks = @doing.doingchecks.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
      flash.now[:danger] = "該当するDo検証はありませんでした。"
    end
    render :index
  end

  private
    # ストロングパラメーター
    def doingcheck_params
      params.require(:doingcheck).permit(:check, :adjust, :estimate_check_at, :check_at, :span, :achivement, :note, :doing_id)
    end

    # Do検証検索
    def doingcheck_search_params
      params.fetch(:search, {}).permit(:estimate_check_at_from, :estimate_check_at_to, :check_at_from, 
        :check_at_from, :check_at_to).merge(subgoal_id: @doing.subgoal_id, doing_id: @doing.id )
      # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
      # ここでの:searchには、フォームから送られてくるparamsの値が入っている
    end

    # paramsハッシュからid取得
    def set_doingcheck
      @doingcheck = Doingcheck.find(params[:id])
    end

end
