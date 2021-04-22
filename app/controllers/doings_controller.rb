class DoingsController < ApplicationController
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_doing, only:[:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user

  def index
    @doings = current_user.doings.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
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
        :pattern, :priority, :impact, :worktime, :easy, :progress, :hold, :note, todo_attributes:
        [
          :todo, :start_day, :finish_day, :estimated_time, :estimated_start_time, :estimated_finish_time, :achivement,
            :actual_start_time, :actual_finish_time, :check, :adjust, :pattern, :progress, :hold, :note
        ]
      )
    end

    # パラメーターからDoを取得
    def set_doing
      @doing = Doing.find(params[:id])
    end
end
