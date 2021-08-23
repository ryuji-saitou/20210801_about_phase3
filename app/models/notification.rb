class Notification < ApplicationRecord

  # default_scope ~ :desc について
  # = デフォルトの並び順を"作成日時の降順"で指定している
  # = 常に新しい通知からデータを取得することが可能
  default_scope -> { order(created_at: :desc) }
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  # optical: true = "nil" を許可する
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

end
