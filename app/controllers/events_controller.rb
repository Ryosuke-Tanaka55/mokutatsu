class EventsController < ApplicationController

  def create
    event = Event.new(event_params)
    event.save!
    @events = Event.where(user_id: current_user.id)
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
      params.require(:event).permit(:title, :start_time, :end_time, :description, :user_id)
    end
  
end
