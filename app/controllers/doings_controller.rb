class DoingsController < ApplicationController
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_doing, only:[:edit, :update, :destroy]
  before_action :loggend_in_user
  before_action :correct_user

  def index
    @doings = current_user.doings.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  def new
  end

  private
    # パラメーターからDoを取得
    def set_doing
      @doing = Doing.find(params[:id])
    end
end
