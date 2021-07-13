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
   # 気軽さ
   enum easy: { 楽: 0, 普通: 1, きつい: 2 }, _prefix: true
   # 優先度
   enum priority: { 高: 0, 中: 1, 低: 2 }, _prefix: true

  # 検索条件
  scope :search, -> (search_params) do  # scopeでsearchメソッドを定義。(search_params)は引数
    return if search_params.blank?  # 検索フォームに値がなければ以下の手順は行わない

    gap_like(search_params[:gap])
      .impact_select(search_params[:impact])
      .worktime_select(search_params[:worktime])   
      .easy_select(search_params[:easy])  
      .priority_select(search_params[:priority])  # 下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
  end

  # if 引数.present?をつけることで、検索フォームに値がない場合は実行されない
  scope :gap_like, -> (gap) { where('gap LIKE ?', "%#{gap}%") if gap.present? }  #scopeを定義。
  scope :impact_select, -> (impact) { where(impact: impact) if impact.present? }  # scopeを定義
  scope :worktime_select, -> (worktime) { where(worktime: worktime) if worktime.present? }  # scopeを定義
  scope :easy_select, -> (easy) { where(easy: easy) if easy.present? }  # scopeを定義
  scope :priority_select, -> (priority) { where(priority: priority) if priority.present? }  # scopeを定義

end
