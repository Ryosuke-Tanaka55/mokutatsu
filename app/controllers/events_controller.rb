class EventsController < ApplicationController

  def index
    @events = Event.where(user_id: current_user.id)
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "スケジュール登録に成功しました。"
      @events = Event.where(user_id: current_user.id)
      redirect_to user_url(current_user.id)
    else
      flash[:danger] = "スケジュール登録に失敗しました。"
      redirect_to user_url(current_user.id)
    end
    
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "スケジュール編集に成功しました。"
    else
      flash[:danger] = "スケジュール編集に失敗しました。"
    end
    redirect_to user_url(current_user.id)
  end

  def destroy
    @event = Event.find(params[:id])
    event.destroy
    redirect_to user_url(current_user.id)
  end

  private
    # ストロングパラメーター
    def event_params
      params.require(:event).permit(:title, :start_time, :end_time, :description, :allday, :color, :user_id, :todo_id)
    end
  
end
