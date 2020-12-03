class Schedule < ApplicationRecord
  belongs_to :user
  has_many :schedules, through: :schedule_conections, source: :schedule

  validates :worked_on, presence: true
  validates :deadline, :presence: true
  validates :goal_index, :presence: true
  validates :achivement, :presence: true
  validates :check, presence: true
  validates :adjust, presence: true
  validates :progress, presence: true

  # 進捗
  enum progress: { 完了: 0, 作業中: 1, 未着手: 2, 中止: 3 }
  # 公開範囲
  enum publish: { 非公開: 0, グループ内のみ: 1,  公開: 2 }
end
