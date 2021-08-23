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
    def reported_by?(user, post)
      reports.where(user_id: user.id, post_id: post.id, comment_id: nil).exists?
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
    # present? = 値が入っていれば処理する
    # scope :メソッド名 -> (引数) {SQL文}
    scope :action_like, -> (action) { where("action LIKE ?", "%#{action}%") if action.present? }
    scope :time_required_from, -> (from) { where("? <= time_required", from) if from.present? }
    scope :time_required_to, -> (to) { where("time_required <= ?", to)   if to.present? }
    scope :budget_from, -> (from) { where("? <= budget", from)        if from.present? }
    scope :budget_to, -> (to) { where("budget <= ?", to)          if to.present? }
    scope :created_at_from, -> (from) { where("? <= created_at: search_date.in_time_zone.all_month", from)    if from.present? }
    scope :created_at_to, -> (to) { where("created_at: search_date.in_time_zone.all_month <= ?", to)      if to.present? }
  # ▲投稿検索機能に関する記述

  # ▼通知機能に関する記述
    # アソシエーション
    has_many :notifications, dependent: :destroy

    # いいね通知のメソッド
    def create_notification_favorite!(current_user)
      # 既に「いいね」されているかを照会
      temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
      # 「いいね」で "Notification" が作成されていない場合のみ下記処理を実行
      # ("いいね"連打のような迷惑行為防止のため)
      if temp.blank?
        notification = current_user.active_notifications.new(
          post_id: id,
          visited_id: user_id,
          action: 'favorite'
        )
        # 自分の投稿に対するいいねの場合は通知済み(checked = true)にする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

  # コメント通知のメソッド
    # ~~~その1~~~
    def create_notification_comment!(current_user, comment_id)
      temp_ids = Comment.select(:user_id).where(post_id: id) # 1.投稿にコメントしたユーザーIDのリストを取得する
                 .where.not(user_id: current_user.id)        # 2.投稿にコメントしたユーザーIDのリストから自分のコメントは除外する
                 .distinct                                   # 3.重複したユーザーIDは除外する
      temp_ids.each do |temp_id|
        save_notification_comment!(current_user, comment_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    end

    # ~~~その2~~~
    def save_notification_comment!(current_user, comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        post_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  # ▲通知機能に関する記述

end
