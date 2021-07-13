class Todo < ApplicationRecord
  belongs_to :doing
  belongs_to :user

  # バリデーション
  validates :todo, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true
  validates :estimated_time, presence: true
  validates :pattern, presence: true, presence: true
  validates :priority, presence: true
  validates :progress, presence: true

  # 開始日は今日以降でないと無効
  validate :start_time_than_fast_than_today_if_invalid
  
  # 開始日より終了日が早い場合は無効
  validate :start_time_than_finish_time_fast_if_invalid

  # 実働開始時間より実働終了時間が早い場合は無効
  validate :actual_start_time_than_actual_finish_time_fast_if_invalid

  def start_time_than_fast_than_today_if_invalid
    errors.add(:start_time, "が過去です。")  if start_time < DateTime.now - 1
  end 
  
  def start_time_than_finish_time_fast_if_invalid
    errors.add(:start_time, "より早い終了日は無効です。") if start_time > finish_time
  end
   
  def actual_start_time_than_actual_finish_time_fast_if_invalid
    if actual_start_time.present? && actual_finish_time.present?
      errors.add(:actual_start_time, "より早い実働終了時間は無効です。") if actual_start_time > actual_finish_time
    end
  end

  # 進捗
  enum progress: { 未着手: 0, 作業中: 1, 完了: 2, 中止: 3 }, _prefix: true
  # 優先度
  enum priority: { 高: 0, 中: 1, 低: 2 }, _prefix: true

   # 検索条件
   scope :search, -> (search_params) do  # scopeでsearchメソッドを定義。(search_params)は引数
    return if search_params.blank?  # 検索フォームに値がなければ以下の手順は行わない

    todo_like(search_params[:todo])
      .start_time_from(search_params[:start_time_from])
      .start_time_to(search_params[:start_time_to])
      .priority_select(search_params[:priority])
      .hold_check(search_params[:hold])   # 下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
  end

  # if 引数.present?をつけることで、検索フォームに値がない場合は実行されない
  scope :todo_like, -> (todo) { where('todo LIKE ?', "%#{todo}%") if todo.present? }  # scopeを定義
  scope :start_time_from, -> (from) { where('? <= start_time', from) if from.present? } # 日付の範囲検索をするため、fromとtoをつけている
  scope :start_time_to, -> (to) { where('start_time <= ?', to) if to.present? }
  scope :priority_select, -> (priority) { where(priority: priority) if priority.present? }  # scopeを定義
  scope :hold_check, -> (hold) { where(hold: hold) if hold.present? }  # scopeを定義

end
