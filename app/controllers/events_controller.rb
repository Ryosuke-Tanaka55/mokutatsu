class EventsController < ApplicationController

  def index
    @events = Event.where(user_id: current_user.id)
  end

  def create
    event = Event.new(event_params)
    if event.save
      flash[:success] = "スケジュール登録に成功しました。"
      @events = Event.where(user_id: current_user.id)
      redirect_to user_url(current_user.id)
    else
      flash[:danger] = "スケジュール登録に失敗しました。"
      redirect_to user_url(current_user.id)
    end
    
  end

  def update
    event = Event.find(params[:id])
    @events = Event.where(user_id: current_user.id)
    event.update(event_params)
  end

  def destroy
    @user = User.find(params[:id])
    event = Event.find(params[:id])
    event.destroy
    redirect_to user_url(@user)
  end

  private
    # ストロングパラメーター
    def event_params
      params.require(:event).permit(:title, :start_time, :end_time, :description, :user_id, :todo_id)
    end
  
end
