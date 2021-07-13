class Doingcheck < ApplicationRecord
  belongs_to :doing

  # バリデーション
  validates :achivement, presence: true
  validates :check, presence: true, length: { minimum: 2 }
  validates :adjust, presence: true, length: { minimum: 2 }
  validates :check_at, presence: true
  validates :estimate_check_at, presence: true
  validates :span, presence: true

  # 検証日が未来の場合は無効
  validate :today_fast_than_check_at_if_invalid

  # 検証予定日は今日以降でないと無効
  validate :estimate_check_at_fast_than_today_if_invalid

  # 検証予定日は検証日以降でないと無効
  validate :estimate_check_at_fast_than_check_at_if_invalid

  def today_fast_than_check_at_if_invalid
    errors.add(:check_at, "が未来の場合は無効です。")  if Date.today + 1 < check_at
  end

  def estimate_check_at_fast_than_today_if_invalid
    errors.add(:estimate_check_at, "が過去の場合は無効です。")  if estimate_check_at < Date.today
  end

  def estimate_check_at_fast_than_check_at_if_invalid
    errors.add(:estimate_check_at, "より早い検証日は無効です。")  if estimate_check_at < check_at
  end

  # 検索条件
  scope :search, -> (search_params) do  # scopeでsearchメソッドを定義。(search_params)は引数
    return if search_params.blank?  # 検索フォームに値がなければ以下の手順は行わない

    estimate_check_at_from(search_params[:estimate_check_at_from])
      .estimate_check_at_to(search_params[:estimate_check_at_to])
      .check_at_from(search_params[:check_at_from])
      .check_at_to(search_params[:check_at_to])  # 下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
  end

  # if 引数.present?をつけることで、検索フォームに値がない場合は実行されない
  scope :estimate_check_at_from, -> (from) { where('? <= estimate_check_at', from) if from.present? } # 日付の範囲検索をするため、fromとtoをつけている
  scope :estimate_check_at_to, -> (to) { where('estimate_check_at <= ?', to) if to.present? }
  scope :check_at_from, -> (from) { where('? <= check_at', from) if from.present? } # 日付の範囲検索をするため、fromとtoをつけている
  scope :check_at_to, -> (to) { where('check_at <= ?', to) if to.present? }
  
end
