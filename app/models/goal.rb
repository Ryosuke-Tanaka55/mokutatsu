class Goal < ApplicationRecord
  belongs_to :user
  # Goalテーブルとのリレーション関係
  has_many :child_goals, through: :parent_childs, source: :child
  has_many :parent_goals, through: :parent_childs, source: :parent

  # 中間テーブル（goal_connection）とのリレーション構築
  has_many :parent_childs, foreign_key: :parent_id
  has_many :parent_childs, foreign_key: :child_id

  # 配下のGoalgap、Goalcheck、Subgoal、Do、ToDo
  has_many :goalgaps, dependent: :destroy
  accepts_nested_attributes_for :goalgaps, allow_destroy: true
  has_many :goalchecks, dependent: :destroy
  has_many :subgoals, dependent: :destroy
  accepts_nested_attributes_for :subgoals, allow_destroy: true
  has_many :doings, through: :subgoals
  has_many :todoes, through: :doings

  # バリデーション
  validates :goal, presence: true
  validates :category, presence: true
  validates :start_day, presence: true
  validates :finish_day, presence: true
  validates :goal_index, presence: true
  validates :progress, presence: true
  
  # 開始日は今日以降出ないと無効
  validate :start_day_fast_than_today_if_invalid

  # 開始日より終了日が早い場合は無効
  validate :start_day_than_finish_day_fast_if_invalid

  def start_day_fast_than_today_if_invalid
    errors.add(:start_day, "が過去です。")  if start_day < Date.today
  end 
  
  def start_day_than_finish_day_fast_if_invalid
    errors.add(:start_day, "より早い終了日は無効です。") if start_day > finish_day
  end

  # カテゴリー
  enum category: { 勉強: 0, 資格: 1, 語学: 2, 運動: 3, ダイエット: 4, 筋トレ: 5, 趣味: 6, 貯金: 7, 起業: 8, 旅行: 9, その他: 10 }, _prefix: true
  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }, _prefix: true
 
end
