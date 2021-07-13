class GoalgapsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_goalgap, only:[:show, :edit, :update, :destroy]
  before_action :correct_user


  def index
    @search_params = goalgap_search_params
    if @search_params.present?
      @goalgaps = @goal.goalgaps.search(@search_params).paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    else
      @goalgaps = @goal.goalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
    end
  end

  def show
  end

  def new
    @goalgap = Goalgap.new
  end

  def create
    @goalgap = @goal.goalgaps.build(goalgap_params)
    if @goalgap.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goal_goalgaps_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @goalgap.update_attributes(goalgap_params)
      flash[:success] = "#{ @goalgap.gap }を編集しました。"
      redirect_to user_goal_goalgaps_url
    else
      flash.now[:danger] = "#{ @goalgap.gap }を編集できませんでした。。"
      render :edit
    end
  end

  def destroy
    @goalgap.destroy
    flash[:success] = "#{ @goalgap.gap }を削除しました。"
    redirect_to user_goal_goalgaps_url
  end

  # ゴールギャップ検索
  def search
    @search_params = goalgap_search_params
    if @goal.goalgaps.search(@search_params).count > 0
      @goalgaps = @goal.goalgaps.search(@search_params).order(created_at: "DESC")
      flash.now[:success] = "#{@goalgaps.count}件ヒットしました。"
    else
      @goalgaps = @goal.goalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
      flash.now[:danger] = "該当するゴールギャップはありませんでした。"
    end
    render :index
  end

  private
    # ストロングパラメーター
    def goalgap_params
      params.require(:goalgap).permit(:gap, :detail, :solution, :impact, :worktime, :easy, :priority, :goal_id)
    end

    def goalgap_search_params
      params.fetch(:search, {}).permit(:gap, :impact, :worktime, :easy, :priority).merge(goal_id: @goal.id)
      # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
      # ここでの:searchには、フォームから送られてくるparamsの値が入っている
    end

    # paramsハッシュからgoalgapを取得
    def set_goalgap
      @goalgap = Goalgap.find(params[:id])
    end
end