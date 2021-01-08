class TodoesController < ApplicationController
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_doing_id
  before_action :set_todo, only:[:show, :edit, :update, :destroy]
  before_action :loggend_in_user
  before_action :correct_user

  def index
    @todoes = current_user.todoes.paginate(page: params[:page], per_page: 20).order(created_at: "DESC")
  end

  def new
    @todo = Todo.new
  end

  def show
  end

  def create
    @todo = @doing.todoes.build(create_todo_params)
    if @todo.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_goals_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    @todo = Todo.where(goal_id: params[:goal_id])
    if @todo.update_attributes(edit_todo_params)
      flash[:success] = "編集に成功しました。"
      redirect_to todos_url
    else
      flash.now[:danger] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @todo.destroy
    flash[:success] = "ToDoを削除しました。"
    redirect_to todos_url
  end

  private
    # ストロングパラメーター
    # 新規登録時
    def create_todo_params
      params.require(:todo).permit(:todo, :worked_on, :start_day, :finish_day, :estimated_time, 
        :estimated_start_time, :estimated_finish_time, :pattern, :priority, :hold, :note, :doing_id)
    end

    # 編集時
    def edit_todo_params
      params.require(:todo).permit(:todo, :worked_on, :start_day, :finish_day, :estimated_time, 
        :estimated_start_time, :estimated_finish_time,:achivement, :pattern, :priority, :hold, :note, :doing_id
      )
    end

    # パラメーターからDoを取得
    def set_todo
      @todo = Todo.find(params[:id])
    end
end

