class NotificationsController < ApplicationController
  before_action :set_user_id

  def destroy
    # 通知を全削除
      @notifications = current_user.passive_notifications.destroy_all
      if @notifications.present?
        flash[:success] = "通知を削除しました。"
      else
        flash[:danger] = "通知はありません。"     
      end
      redirect_to request.referer
  end
end
