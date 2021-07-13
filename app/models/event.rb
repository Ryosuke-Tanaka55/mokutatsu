class Event < ApplicationRecord
  belongs_to :user

  default_scope -> { order(start_time: :asc) }

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate  :start_end_check

  enum color: { 緑色: 0, 青色: 1, 黄色: 2, 赤色: 3, 水色: 4, 桃色: 5, 灰色: 6 }

  # 時間の矛盾を防ぐ
  def start_end_check
    if self.start_time.present? && self.end_time.present?
      errors.add(:end_time, "が開始時間を上回っています。正しく記入してください。") if self.start_time > self.end_time
    end
  end
end
