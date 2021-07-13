class Doing < ApplicationRecord
  belongs_to :subgoal

  # 配下のDoingcheck、ToDo
  has_many :doingchecks, dependent: :destroy
  has_many :todoes, dependent: :destroy
  accepts_nested_attributes_for :todoes, allow_destroy: true

  # バリデーション
  validates :doing, presence: true
  validates :start_day, presence: true
  validates :finish_day, presence: true
  validates :pattern, presence: true
  validates :priority, presence: true
  validates :impact, presence: true
  validates :worktime, presence: true
  validates :easy, presence: true
  validates :progress, presence: true

  # 開始日は今日以降出ないと無効
  validate :start_day_fast_than_today_if_invalid

  # 開始日より終了日が早い場合は無効
  validate :start_day_than_finish_day_fast_if_invalid

  def start_day_fast_than_today_if_invalid
    errors.add(:start_day, "が過去です。")  if start_day < Date.today
  end 
  
  def start_day_than_finish_day_fast_if_invalid
    errors.add(:start_day, "より早い終了日は無効です。") if start_day > finish_day
  end

  # 優先度
  enum priority: { 高: 0, 中: 1, 低: 2 }, _prefix: true
  # インパクト
  enum impact: { 大: 0, 中: 1, 小: 2 }, _prefix: true
  # 工数
  enum worktime: { 多: 0, 普通: 1, 少: 2 }, _prefix: true
  # 気軽さ
  enum easy: { 楽: 0, 普通: 1, きつい: 2 }, _prefix: true
  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }, _prefix: true

   # 検索条件
   scope :search, -> (search_params) do  # scopeでsearchメソッドを定義。(search_params)は引数
    return if search_params.blank?  # 検索フォームに値がなければ以下の手順は行わない

    doing_like(search_params[:doing])
      .start_day_from(search_params[:start_day_from])
      .start_day_to(search_params[:start_day_to])
      .priority_select(search_params[:priority])
      .hold_check(search_params[:hold])   # 下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
  end

  # if 引数.present?をつけることで、検索フォームに値がない場合は実行されない
  scope :doing_like, -> (doing) { where('doing LIKE ?', "%#{doing}%") if doing.present? }  # scopeを定義
  scope :start_day_from, -> (from) { where('? <= start_day', from) if from.present? } # 日付の範囲検索をするため、fromとtoをつけている
  scope :start_day_to, -> (to) { where('start_day <= ?', to) if to.present? }
  scope :priority_select, -> (priority) { where(priority: priority) if priority.present? }  # scopeを定義
  scope :hold_check, -> (hold) { where(hold: hold) if hold.present? }  # scopeを定義

end
