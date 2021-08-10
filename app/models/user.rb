class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy

  # ▼フォロー・フォロワーに関する記述
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # follower_idを参照
  has_many :followed_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # followed_idを参照
  has_many :followings, through: :follower_relationships, source: :followed # followings = follower_idを経由して followed(user)_id を参照
  has_many :followers, through: :followed_relationships, source: :follower # followers  = followed_idを経由して follower(user)_id を参照
  # ▲フォロー・フォロワーに関する記述

  validates :user_name           , presence: true
  validates :user_name_id        , presence: true
  validates :birthday            , presence: true
  validates :profile_introduction, length: { maximum: 200 }
  validates :profile_sns_link    , format: /\A#{URI::regexp(%w(http https))}\z/ # urlフォーマットのみ入力可
  validates :is_deleted          , presence: true
end
