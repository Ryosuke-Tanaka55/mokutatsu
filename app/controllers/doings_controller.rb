class DoingsController < ApplicationController
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_doing, only:[:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user

  def index
    @search_params = doing_search_params
    if @search_params.present?
      @doings = @subgoal.doings.search(@search_params).paginate(page: params[:page], per_page: 20).order(start_day: "DESC")
    else
      @doings = @subgoal.doings.paginate(page: params[:page], per_page: 20).order(start_day: "DESC")
    end
  end

  def  show 
  end

  def new
    @doing = Doing.new
  end

  def create
    @doing = @subgoal.doings.build(create_doing_params)
    if @doing.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goal_subgoal_doings_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end

  def update
    if @doing.update_attributes(edit_doing_params)
      flash[:success] = "「#{ @doing.doing }」の編集に成功しました。"
      redirect_to user_goal_subgoal_doings_url
    else
      flash.now[:danger] = "「#{ @doing.doing }」の編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @doing.destroy
    flash[:success] = "「#{ @doing.doing }」を削除しました。"
    redirect_to user_goal_subgoal_doings_url
  end

  # Do検索
  def search
    @search_params = doing_search_params
    if @subgoal.doings.search(@search_params).count > 0
      @doings = @subgoal.doings.search(@search_params).order(start_day: "DESC")
      flash.now[:success] = "#{ @doings.count }件ヒットしました。"
    else
      @doings = @subgoal.doings.paginate(page: params[:page], per_page: 20).order(start_day: "DESC")
      flash.now[:danger] = "該当するDoはありませんでした。"
    end
    render :index
  end

  private
    # ストロングパラメーター
    # 新規登録時
    def create_doing_params
      params.require(:doing).permit(:doing, :start_day, :finish_day, :pattern, 
        :priority, :impact, :worktime, :easy, :hold, :note, :subgoal_id)
    end

     # 編集時
     def edit_doing_params
      params.require(:doing).permit(:doing, :start_day, :finish_day, :achivement, :check, :adjust,
        :pattern, :priority, :impact, :worktime, :easy, :progress, :hold, :note, :subgoal_id)
    end

    # Do検索
    def doing_search_params
      params.fetch(:search, {}).permit(:doing, :start_day_from, :start_day_to, 
        :priority, :hold).merge(goal_id: @subgoal.goal_id, subgoal_id: @subgoal.id)
      # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
      # ここでの:searchには、フォームから送られてくるparamsの値が入っている
    end

    # パラメーターからDoを取得
    def set_doing
      @doing = Doing.find(params[:id])
    end
end
