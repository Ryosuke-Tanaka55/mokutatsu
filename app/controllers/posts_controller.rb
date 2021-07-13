class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user, only: [:show_own_post]
  before_action :set_user_id, only: [:index, :create, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :admin_or_correct_user, only: [:destroy]
  
  def index
    @feed_items = current_user.feed.paginate(page: params[:page])
    @comment = Comment.new
    @posts = Post.order(created_at: :desc).paginate(page: params[:page])
    @notifications = current_user.passive_notifications.paginate(page: params[:page], per_page: 5)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def show 
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    #新着順で表示
    @comments = @post.comments.order(created_at: :desc)
  end

  # ユーザー自身の投稿
  def show_own_post
    @post = current_user.posts.build
    @posts = @user.posts.paginate(page: params[:page])
    @notifications = current_user.passive_notifications.paginate(page: params[:page], per_page: 5)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.title = "なし" if @post.title.blank?
    if @post.content.blank?
      flash[:danger] = "投稿内容は必須です。"
      redirect_to posts_show_own_post_user_url(current_user) and return
    end
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
    path = Rails.application.routes.recognize_path(request.referer) # どこから画面遷移してきたかを取得
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    # showアクションの場合
    if path[:action] == "show"
      redirect_to posts_show_own_post_user_url(@user) and return
    # showアクションの以外場合
    else
      redirect_to request.referrer 
    end
  end

  private
    # ストロングパラメーター
    def post_params
      params.require(:post).permit(:title, :content, :post_image).merge(user_id: current_user.id)
    end

    # paramsハッシュからpostを取得
    def set_post
      @post = Post.find(params[:id])
    end
end
