class PostImage < ApplicationRecord
  belongs_to :post

  # 画像アップロードのための記述
  mount_uploader :post_image, ImageUploader

end
