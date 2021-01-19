class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc).limit(8))
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "新規作成に成功しました。"
      render :create
    else
      render :new
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
    render :index
  end

  private
  # ストロングパラメーター
  def post_params
    params.require(:post).permit(:content, :image_id, :user_id)
  end

  # paramsハッシュからpostを取得
  def set_post
    @post = Post.find(parasm[:id])
  end
end
