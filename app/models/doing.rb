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
