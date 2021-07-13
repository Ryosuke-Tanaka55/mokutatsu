class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :admin_or_correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    #投稿に紐づいたコメントを作成
    @comment = @post.comments.build(comment_params)
    @comment.save
    # 通知機能
    @post.create_notification_comment!(current_user, @comment.id)
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :post_id).merge(user_id: current_user.id)
  end
end
