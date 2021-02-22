class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user, only: [:show, :show_own_post]
  before_action :set_user_id, only: [:index, :create]
  before_action :set_post, only: [:edit, :update, :destroy]
  
  def index
    @feed_items = current_user.feed.paginate(page: params[:page])
    @comment = Comment.new
    @posts = Post.order(created_at: :desc).paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    #新着順で表示
    @comments = @post.comments.order(created_at: :desc)
  end

  # ユーザー自身の投稿
  def show_own_post
    @post = current_user.posts.build
    @posts = @user.posts.paginate(page: params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @posts = current_user.posts.paginate(page: params[:page])
    @post = current_user.posts.build(post_params)
    @post.title = "なし" if @post.title.blank?
    @post.content = "なし" if @post.content.blank?
    if @post.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to posts_show_own_post_user_url(current_user)
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
      params.require(:post).permit(:title, :content, {images: []} )
    end

    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:comment, :post_id, :user_id)
    end

    # paramsハッシュからpostを取得
    def set_post
      @post = Post.find(params[:id])
    end
end
