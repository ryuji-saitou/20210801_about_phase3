class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts    , dependent: :destroy
  has_many :comments , dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports  , dependent: :destroy

  validates :user_name           , presence: true
  validates :user_name_id        , presence: true, uniqueness: true
  validates :birthday            , presence: true
  validates :profile_introduction, length: { maximum: 200 }
  # validates :profile_sns_link    , format: /\A#{URI::regexp(%w(http https))}\z/ # urlフォーマットのみ入力可

  # ▼フォロー・フォロワー機能に関する記述
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy # follower_idを参照
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # followed_idを参照
  has_many :followings, through: :relationships, source: :followed # followings = follower_idを経由して followed(user)_id を参照
  has_many :followers, through: :reverse_of_relationships, source: :follower # followers  = followed_idを経由して follower(user)_id を参照

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  # ▲フォロー・フォロワーに関する記述

end
