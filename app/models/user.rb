class User < ApplicationRecord
  include CommonModule

  # 配下ゴールの関連付け
  has_many :goals, dependent: :destroy
  has_many :goalgaps, through: :goals, dependent: :destroy
  has_many :subgoals, through: :goals, dependent: :destroy
  has_many :subgoalgaps, through: :subgoals, dependent: :destroy
  has_many :doings, through: :subgoals, dependent: :destroy
  has_many :todoes, through: :doings, dependent: :destroy

  # 投稿、コメント、いいね関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", 
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # 「remember_token」という仮想の属性を作成
  attr_accessor :remember_token
  
  # emailを小文字にしてから保存
  before_save { self.email = email.downcase }

  # バリデーション
  validates :name, presence: true, length: { maximum: 50 }
  validates :nickname, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

   # 利用規約同意確認
   validates :agreement, presence: {message: "が必要です。" }

   # プロフィール画像をアップロード
   mount_uploader :image, ImageUploader

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためハッシュ化したトークンをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致すればtrueを返す
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はflaseを返すて終了
    return flase if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # フォロー関係

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                OR user_id = :user_id", user_id: id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy    
  end

  # 現在のユーザーがフォローしていたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 既にいいねしているかどうか
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

end
