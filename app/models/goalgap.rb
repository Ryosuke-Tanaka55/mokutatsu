class Goalgap < ApplicationRecord
  belongs_to :goal

  # バリデーション
  validates :gap, presence: true, length: { minimum: 2 }
  validates :solution, presence: true, length: { minimum: 2 }
  validates :impact, presence: true
  validates :worktime, presence: true
  validates :easy, presence: true
  validates :priority, presence: true

   # インパクト
   enum impact: { 大: 0, 中: 1, 小: 2 }, _prefix: true
   # 工数
   enum worktime: { 多: 0, 普通: 1, 少: 2 }, _prefix: true
   # 手軽さ
   enum easy: { 楽: 0, 普通: 1, きつい: 2 }, _prefix: true
   # 優先度
   enum priority: { 高: 0, 中: 1, 低: 2 }, _prefix: true

end
