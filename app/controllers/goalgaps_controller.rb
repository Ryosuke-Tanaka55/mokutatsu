class GoalgapsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_goalgap, only:[:show, :edit, :update, :destroy]
  before_action :correct_user


  def index
    @goalgaps = current_user.goalgaps.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
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

  private
    # ストロングパラメーター
    def goalgap_params
      params.require(:goalgap).permit(:gap, :detail, :solution, :impact, 
        :worktime, :easy, :priority, :goal_id)
    end

    # paramsハッシュからgoalgapを取得
    def set_goalgap
      @goalgap = Goalgap.find(params[:id])
    end
end
