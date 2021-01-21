class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  # refile
  attachment :image

  # バリデーション
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
end
