class Comment < ApplicationRecord
  include CommonModule
  belongs_to :user
  belongs_to :post

  # 画像
  has_many_attached :images

  # バリデーション
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :comment, presence: true, allow_nil: true
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                        message: "有効な画像形式である必要があります。" },
                    size:         { less_than: 5.megabytes,
                                    message: "5MB以下を選択してください。" }
end
