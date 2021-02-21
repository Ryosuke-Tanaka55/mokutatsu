module CommonModule
  extend ActiveSupport::Concern

  # クラスメソッド  
  module ClassMethods
    # 表示用のリサイズ済み画像を返す
    def display_image
      image.variant(resize_to_limit: [500, 500])
    end
  end

end