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

  # 開始日は今日以降出ないと無効
  validate :start_day_fast_than_today_if_invalid

  # 開始日より終了日が早い場合は無効
  validate :start_day_than_finish_day_fast_if_invalid

  # 予定開始時間は今日以降出ないと無効
  validate :estimated_start_time_fast_than_today_if_invalid

  # 予定開始時間より予定終了時間が早い場合は無効
  validate :estimated_start_time_than_estimated_finish_time_fast_if_invalid

  # 実働開始時間より実働終了時間が早い場合は無効
  validate :actual_start_time_than_estimated_finish_time_fast_if_invalid

  def start_day_fast_than_today_if_invalid
    errors.add(:start_day, "が過去です。")  if start_day < Date.today
  end 
  
  def start_day_than_finish_day_fast_if_invalid
    errors.add(:start_day, "より早い終了日は無効です。") if start_day > finish_day
  end

  def estimated_start_time_fast_than_today_if_invalid
    errors.add(:estimated_start_time, "が過去です。")  if start_day < Date.today
  end 
  
  def estimated_start_time_than_estimated_finish_time_fast_if_invalid
    errors.add(:estimated_start_time, "より早い予定終了時間は無効です。") if estimated_start_time > estimated_finish_time
  end
   
  def actual_start_time_than_actual_finish_time_fast_if_invalid
    errors.add(:actual_start_time, "より早い実働終了時間は無効です。") if actual_start_time > actual_finish_time
  end

  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }, _prefix: true
  # 優先度
  enum priority: { 高: 0, 中: 1, 低: 2 }, _prefix: true
end
