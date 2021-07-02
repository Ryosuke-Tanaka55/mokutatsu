class TodoesController < ApplicationController
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_doing_id
  before_action :set_todo, only:[:show, :edit, :update, :destroy]
  before_action :logged_in_user
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
      redirect_to user_goal_subgoal_doing_todoes_url
    else
      flash.now[:danger] = "新規作成に失敗しました。"     
      render :new
    end
  end

  def edit
  end
  
  def update
    if @todo.update_attributes(edit_todo_params)
      flash[:success] = "「#{ @todo.todo }」編集に成功しました。"
      redirect_to user_goal_subgoal_doing_todoes_url
    else
      flash.now[:danger] = "「#{ @todo.todo }」の編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @todo.destroy
    flash[:success] = "#{ @todo.todo }を削除しました。"
    redirect_to user_goal_subgoal_doing_todoes_url
  end

  private
    # ストロングパラメーター
    # 新規登録時
    def create_todo_params
      params.require(:todo).permit(:todo, :worked_on, :start_time, :finish_time, :estimated_time, :pattern, 
        :priority, :hold, :note, :doing_id).merge(user_id: current_user.id)
    end

    # 編集時
    def edit_todo_params
      params.require(:todo).permit(:todo, :worked_on, :start_time, :finish_time, :estimated_time, 
        :actual_start_time, :actual_finish_time, :achivement, :check, :adjust, :pattern, :priority, :hold, :note, :doing_id
      )
    end

    # パラメーターからDoを取得
    def set_todo
      @todo = Todo.find(params[:id])
    end
end
