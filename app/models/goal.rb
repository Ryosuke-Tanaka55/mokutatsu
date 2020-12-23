class Goal < ApplicationRecord
  belongs_to :user
  # Goalテーブルとのリレーション関係
  has_many :child_goals, through: :parent_childs, source: :child
  has_many :parent_goals, through: :parent_childs, source: :parent

  # 中間テーブル（goal_connection）とのリレーション構築
  has_many :parent_childs, foreign_key: :parent_id
  has_many :parent_childs, foreign_key: :child_id

  # 配下のSubgoal、Do、ToDo
  has_and_belongs_to_many :subgoals
  has_many :does, through: :subgoals
  has_many :todoes, through: :does

  validates :goal, presence: true
  validates :start_day, presence: true
  validates :finish_day, presence: true
  validates :goal_index, presence: true
  validates :progress, presence: true
  validates :hold, presence: true
  validates :publish, presence: true

  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }
  # 公開範囲
  enum publish: { 非公開: 0, グループ内のみ: 1,  公開: 2 }
end
