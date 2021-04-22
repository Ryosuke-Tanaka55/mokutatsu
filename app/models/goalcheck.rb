class Goalcheck < ApplicationRecord
  belongs_to :goal

  # バリデーション
  validates :check, presence: true, length: { minimum: 2 }
  validates :adjust, presence: true, length: { minimum: 2 }
  validates :estimate_check_at, presence: true
  validates :span, presence: true
  validates :achivement, presence: true
end
