class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 画像
  has_many_attached :images
  
  # 通知機能
  has_many :notifications, dependent: :destroy

  # バリデーション
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :comment, presence: true, allow_nil: true

end
