class Goal < ApplicationRecord
  belongs_to :user
  # Goalテーブルとのリレーション関係
  has_many :child_goals, through: :parent_childs, source: :child
  has_many :parent_goals, through: :parent_childs, source: :parent

  # 中間テーブル（goal_connection）とのリレーション構築
  has_many :parent_childs, foreign_key: :parent_id
  has_many :parent_childs, foreign_key: :child_id

  # 配下のSubgoal、Do、ToDo
  has_many :subgoals, dependent: :destroy
  accepts_nested_attributes_for :subgoals
  has_many :doings, through: :subgoals
  accepts_nested_attributes_for :doings
  has_many :todoes, through: :doings
  accepts_nested_attributes_for :todoes

  validates :goal, presence: true
  validates :category, presence: true
  validates :start_day, presence: true
  validates :finish_day, presence: true
  validates :goal_index, presence: true
  validates :progress, presence: true
  validates :publish, presence: true

  # カテゴリー
  enum category: { 勉強: 0, 資格: 1, 語学: 2, 運動: 3, ダイエット: 4, 筋トレ:5, 趣味: 6, 貯金: 7, 起業:8, 旅行: 9, その他: 10 }
  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }, _prefix: true
  # 公開範囲
  enum publish: { 非公開: 0, グループ内のみ: 1,  公開: 2 }
end
