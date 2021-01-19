class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  # refile
  attachment :image
end
