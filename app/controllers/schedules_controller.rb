class SchedulesController < ApplicationController
  before_action :set_schedule, only:[:edit, :update, :destroy]

  def index
    @shedules = Schedule.pagenate(page: params[:user_id], page: 20 )
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @shecdule.user_id = current_user.id
    @schedule.save
    flash[:success] = "目標を作成しました。"
  end

  def update
    schedule = Schedule.find(params[:id])
    @schedules = Schedule.where(user_id: current_user.id)
    if schedule.update(schedule_params)
      flash[:success] = "目標を編集しました。"
      redirect_to @user
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])
    schedule = Schedule.find(params[:id])
    schedule.destroy
    flash[:success] = "目標を削除しました。"
    redirect_to @user
  end

  private
    # ストロングパラメーター
    def schedule_params
      params_require(:schedule).permit(:worked_on, :goal, :tag, :start_day, :finish_day, :goal_index, :achivement,
                                        :check, :adjust, :progress, :hold, :publish, :note, :user_id)
    end
end
