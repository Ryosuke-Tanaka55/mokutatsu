class SubgoalgapsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_subgoalgap, only:[:show, :edit, :update, :destroy]
  before_action :correct_user


  def index
    @subgoalgaps = current_user.subgoalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
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

  private
    # ストロングパラメーター
    def subgoalgap_params
      params.require(:subgoalgap).permit(:gap, :detail, :solution, :term, :impact, :worktime, :easy, :priority, :goal_id)
    end

    # paramsハッシュからsubgoalgapを取得
    def set_subgoalgap
      @subgoalgap = Subgoalgap.find(params[:id])
    end
end
