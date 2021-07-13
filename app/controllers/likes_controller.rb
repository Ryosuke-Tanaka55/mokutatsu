class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_id
  before_action :post_params
  
  def create
    @like = current_user.likes.new(post_id: @post.id)
    @like.save
    # 通知機能
    @post.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: @post.id)
    @like.destroy
  end

  private
    # ストロングパラメーター
    def post_params
      @post = Post.find(params[:post_id])
    end
end
