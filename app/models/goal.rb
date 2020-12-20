class Goal < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :goals, through: :goal_conection, source: :goal

  validates :goal, presence: true
  validates :start_day, presence: true
  validates :finish_day, presence: true
  validates :goal_index, presence: true

  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }
  # 公開範囲
  enum publish: { 非公開: 0, グループ内のみ: 1,  公開: 2 }
end
