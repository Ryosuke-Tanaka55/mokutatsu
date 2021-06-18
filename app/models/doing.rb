class Doing < ApplicationRecord
  belongs_to :subgoal

  # 配下のDoingcheck、ToDo
  has_many :doingchecks, dependent: :destroy
  has_many :todoes, dependent: :destroy
  accepts_nested_attributes_for :todoes, allow_destroy: true

  # バリデーション
  validates :doing, presence: true
  validates :start_day, presence: true
  validates :finish_day, presence: true
  validates :pattern, presence: true
  validates :priority, presence: true
  validates :impact, presence: true
  validates :worktime, presence: true
  validates :easy, presence: true
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

  # 優先度
  enum priority: { 高: 0, 中: 1, 低: 2 }, _prefix: true
  # インパクト
  enum impact: { 大: 0, 中: 1, 小: 2 }, _prefix: true
  # 工数
  enum worktime: { 多: 0, 普通: 1, 少: 2 }, _prefix: true
  # 手軽さ
  enum easy: { 楽: 0, 普通: 1, きつい: 2 }, _prefix: true
  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }, _prefix: true
end
