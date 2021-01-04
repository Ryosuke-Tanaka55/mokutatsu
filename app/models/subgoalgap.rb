class Subgoalgap < ApplicationRecord
  belongs_to :subgoal

  validates :gap, presence: true, length: { minimum: 2 }
  validates :solution, presence: true, length: { minimum: 2 }
  validates :impact, presence: true
  validates :term, presence: true
  validates :worktime, presence: true
  validates :easy, presence: true
  validates :priority, presence: true

  # 配下のSubgoalgap、Do、ToDo
  has_many :subgoalgaps, dependent: :destroy
  has_many :doings, dependent: :destroy
  has_many :todoes, through: :doings

  # インパクト
  enum impact: { 大: 0, 中: 1, 小: 2 }, _prefix: true
  # 工数
  enum worktime: { 多: 0, 普通: 1, 少: 2 }, _prefix: true
  # 手軽さ
  enum easy: { 楽: 0, 普通: 1, きつい: 2 }, _prefix: true
  # 優先度
  enum priority: { 高: 0, 中: 1, 低: 2 }, _prefix: true

end
