class Todo < ApplicationRecord
  belongs_to :doing

  # 配下のイベント
  has_many :events, dependent: :destroy

  # バリデーション
  validates :todo, presence: true
  validates :start_day, presence: true
  validates :finish_day, presence: true
  validates :estimated_time, presence: true
  validates :estimated_start_time, presence: true
  validates :estimated_finish_time, presence: true
  validates :pattern, presence: true, presence: true
  validates :priority, presence: true
  validates :progress, presence: true

  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }, _prefix: true
  # 優先度
  enum priority: { 高: 0, 中: 1, 低: 2 }, _prefix: true
end
