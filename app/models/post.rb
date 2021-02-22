class Post < ApplicationRecord
  belongs_to :user

  # いいね、コメント、画像
  has_many :likes, dependent: :destroy
  has_many_attached :images
  has_many :comments, dependent: :destroy

  # バリデーション
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true

end

