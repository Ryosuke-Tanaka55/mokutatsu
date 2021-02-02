class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many_attached :images

  # バリデーション
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "有効な画像形式である必要があります。" },
                    size:         { less_than: 5.megabytes,
                                    message: "5MB以下を選択してください。" }
  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
