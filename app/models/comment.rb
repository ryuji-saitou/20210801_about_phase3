class Comment < ApplicationRecord
  has_many   :reports, dependent: :destroy
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :comment, presence: true

  # ▼コメント通報機能に関する記述
  def reported_by?(user, post)
    reports.where(user_id: user.id, post_id: post.id).exists?
  end
  # ▲コメント通報機能に関する記述

  # ▼通知機能に関する記述
  has_many :notifications, dependent: :destroy
  # ▲通知機能に関する記述

end
