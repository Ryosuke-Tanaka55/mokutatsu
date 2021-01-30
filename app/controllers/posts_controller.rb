class PostsController < ApplicationController
  before_action :loggend_in_user
  before_action :set_post, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.order(created_at: :desc).paginate(page: params[:page])
    @feed_items = current_user.feed.paginate(page: params[:page])
    @post = current_user.posts.build
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  # ユーザー自身の投稿
  def show_own_post
    @user = User.find(params[:id])
    @post = current_user.posts.build
    @posts =current_user.posts.paginate(page: params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @posts =current_user.posts.paginate(page: params[:page])
    @post.images.attach(params[:images])
    if @post.save
      flash[:success] = "新規作成に成功しました。"
      render :show_own_post
    else
      render :show_own_post
    end
  end

  def edit
  end
  
  def update
    if @post.update_attributes(post_params)
      flash[:success] = "投稿を編集しました。"
      render :create
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to request.referrer || :index  # 一つ前のURLかindexへリダイレクト
  end

  private
    # ストロングパラメーター
    def post_params
      params.require(:post).permit(:content, :images [], :user_id)
    end

    # paramsハッシュからpostを取得
    def set_post
      @post = Post.find(params[:id])
    end
end
