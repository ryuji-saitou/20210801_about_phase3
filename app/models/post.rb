class Post < ApplicationRecord
  has_many   :reports, dependent: :destroy
  has_many   :comments, dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :post_images, dependent: :destroy
  belongs_to :user
  accepts_attachments_for :post_images, attachment: :image

  validates :user_id      , presence: true
  validates :action       , presence: true
  validates :time_required, presence: true
  validates :budget       , presence: true

  # ▼いいね機能に関する記述
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  # ▲いいね機能に関する記述

  # ▼投稿通報機能に関する記述
  def reported_by?(user)
    reports.where(user_id: user.id).exists?
  end
  # ▲投稿通報機能に関する記述

  # ▼投稿検索機能に関する記述
  scope :post_search, -> (search_params) do
    return if search_params.blank?
    action_like(search_params[:action])
    .time_required_from(search_params[:time_required_from])
    .time_required_to(search_params[:time_required_to])
    .budget_from(search_params[:budget_from])
    .budget_to(search_params[:budget_to])
    .created_at_from(search_params[:created_at_from])
    .created_at_to(search_params[:created_at_to])
  end
  scope :action_like, -> (action) { where("action LIKE ?", "%#{action}%") if action.present? }
  scope :time_required_from, -> (from) { where("? <= time_required", from) if from.present? }
  scope :time_required_to, -> (to) { where("time_required <= ?", to)   if to.present? }
  scope :budget_from, -> (from) { where("? <= budget", from)        if from.present? }
  scope :budget_to, -> (to) { where("budget <= ?", to)          if to.present? }
  scope :created_at_from, -> (from) { where("? <= created_at: search_date.in_time_zone.all_month", from)    if from.present? }
  scope :created_at_to, -> (to) { where("created_at: search_date.in_time_zone.all_month <= ?", to)      if to.present? }
  # present? = 値が入っていれば処理する
  # scope :メソッド名 -> (引数) {SQL文}
  # ▲投稿検索機能に関する記述
end
