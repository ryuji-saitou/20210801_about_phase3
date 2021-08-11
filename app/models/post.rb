class Post < ApplicationRecord
  attachment :post_image

  has_many   :reports, dependent: :destroy
  has_many   :comments, dependent: :destroy
  has_many   :favorites, dependent: :destroy
  belongs_to :user

  validates :user_id      , presence: true
  validates :action       , presence: true
  validates :time_required, presence: true
  validates :budget       , presence: true

  # ▼いいね機能に関する記述
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  # ▲いいね機能に関する記述
end
