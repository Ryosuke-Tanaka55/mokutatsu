class TodoesController < ApplicationController
  before_action :set_user_id
  before_action :set_goal_id
  before_action :set_subgoal_id
  before_action :set_doing_id
  before_action :set_todo, only:[:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user

  def index
    @search_params = todo_search_params
    if @search_params.present?
      @todoes = @doing.todoes.search(@search_params).paginate(page: params[:page], per_page: 20).order(start_time: "DESC")
    else
      @todoes = @doing.todoes.paginate(page: params[:page], per_page: 20).order(start_time: "DESC")
    end
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

  # ToDo検索
  def search
    @search_params = todo_search_params
    if @doing.todoes.search(@search_params).count > 0
      @todoes = @doing.todoes.search(@search_params).order(start_time: "DESC")
      flash.now[:success] = "#{ @todoes.count }件ヒットしました。"
    else
      @todoes = @doing.todoes.paginate(page: params[:page], per_page: 20).order(start_time: "DESC")
      flash.now[:danger] = "該当するToDoはありませんでした。"
    end
    render :index
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

      # Todo検索
      def todo_search_params
        params.fetch(:search, {}).permit(:todo, :start_time_from, :start_time_to, 
          :priority, :hold).merge(subgoal_id: @doing.subgoal_id, doing_id: @doing.id)
        # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
        # ここでの:searchには、フォームから送られてくるparamsの値が入っている
      end

    # パラメーターからDoを取得
    def set_todo
      @todo = Todo.find(params[:id])
    end
end
