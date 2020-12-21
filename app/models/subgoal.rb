class Subgoal < ApplicationRecord
  belongs_to :goal

  validates :subgoal, presence: true
  validates :start_day, presence: true
  validates :finish_day, presence: true
  validates :type, presence: true
  validates :gap, presence: true, length: { minimum: 2 }
  validates :solution, presence: true, length: { minimum: 2 }
  validates :priority, presence: true
  validates :impact, presence: true
  validates :worktime, presence: true
  validates :easy, presence: true
  validates :progress, presence: true
  validates :hold, presence: true

  # 優先度
  enum priority: { A: 0, B: 1, C: 2 }
  # インパクト
  enum impact: { A: 0, B: 1, C: 2 }
  # 工数
  enum worktime: { A: 0, B: 1, C: 2 }
  # 手軽さ
  enum easy: { A: 0, B: 1, C: 2 }
  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }

end
