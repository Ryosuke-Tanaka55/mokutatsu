class Subgoalcheck < ApplicationRecord
  belongs_to :subgoal

  # バリデーション
  validates :check, presence: true, length: { minimum: 2 }
  validates :adjust, presence: true, length: { minimum: 2 }
  validates :estimate_check_at, presence: true
  validates :span, presence: true
  validates :achivement, presence: true

  # 検証予定日は今日以降出ないと無効
  validate :estimate_check_at_fast_than_today_if_invalid

  # 検証日は今日以降出ないと無効
  validate :check_at_fast_than_today_if_invalid

  def estimate_check_at_fast_than_today_if_invalid
    errors.add(:estimate_check_at, "が過去です。")  if estimate_check_at < Date.today
  end

  def estimate_check_at_fast_than_today_if_invalid
    errors.add(:check_at, "が過去です。")  if check_at < Date.today
  end
  
end
