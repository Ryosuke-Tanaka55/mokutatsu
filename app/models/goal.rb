class Goal < ApplicationRecord
  belongs_to :user

  # 配下のGoalgap、Goalcheck、Subgoal、Do、ToDo
  has_many :goalgaps, dependent: :destroy
  accepts_nested_attributes_for :goalgaps, allow_destroy: true
  has_many :goalchecks, dependent: :destroy
  has_many :subgoals, dependent: :destroy
  accepts_nested_attributes_for :subgoals, allow_destroy: true
  has_many :doings, through: :subgoals
  has_many :todoes, through: :doings

  # バリデーション
  validates :goal, presence: true
  validates :category, presence: true
  validates :start_day, presence: true
  validates :finish_day, presence: true
  validates :goal_index, presence: true
  validates :progress, presence: true
  
  # 開始日は今日以降でないと無効
  validate :start_day_fast_than_today_if_invalid

  # 開始日より終了日が早い場合は無効
  validate :start_day_than_finish_day_fast_if_invalid

  def start_day_fast_than_today_if_invalid
    errors.add(:start_day, "が過去です。")  if start_day < Date.today
  end 
  
  def start_day_than_finish_day_fast_if_invalid
    errors.add(:start_day, "より早い終了日は無効です。") if start_day > finish_day
  end

  # カテゴリー
  enum category: { 勉強: 0, 資格: 1, 語学: 2, 運動: 3, ダイエット: 4, 筋トレ: 5, 趣味: 6, 貯金: 7, 起業: 8, 旅行: 9, その他: 10 }, _prefix: true
  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }, _prefix: true

  # 検索条件
  scope :search, -> (search_params) do  # scopeでsearchメソッドを定義。(search_params)は引数
    return if search_params.blank?  # 検索フォームに値がなければ以下の手順は行わない

    goal_like(search_params[:goal])
      .start_day_from(search_params[:start_day_from])
      .start_day_to(search_params[:start_day_to])
      .progress_select(search_params[:progress])
      .hold_check(search_params[:hold])   # 下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
  end

  # if 引数.present?をつけることで、検索フォームに値がない場合は実行されない
  scope :goal_like, -> (goal) { where('goal LIKE ?', "%#{goal}%") if goal.present? }  #scopeを定義。
  scope :start_day_from, -> (from) { where('? <= start_day', from) if from.present? } # 日付の範囲検索をするため、fromとtoをつけている
  scope :start_day_to, -> (to) { where('start_day <= ?', to) if to.present? }
  scope :progress_select, -> (progress) { where(progress: progress) if progress.present? }  # scopeを定義
  scope :hold_check, -> (hold) { where(hold: hold) if hold.present? }  # scopeを定義
  
end
