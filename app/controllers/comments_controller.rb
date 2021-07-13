class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :admin_or_correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    #投稿に紐づいたコメントを作成
    @comment = @post.comments.build(comment_params)
    if @comment.save
      # 通知機能
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:success] = "コメント投稿に成功しました。"
    else
      flash[:danger] = "コメント投稿に失敗しました。"
    end
    redirect_to user_post_url(@user.id, @post.id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      @post = Post.find(params[:post_id])
      flash[:success] = "コメント削除に成功しました。"
    else
      flash[:danger] = "コメント削除に失敗しました。"
    end
      redirect_to user_post_url(@user.id, @post.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :post_id).merge(user_id: current_user.id)
  end
end
