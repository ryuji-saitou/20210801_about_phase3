class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts    , dependent: :destroy
  has_many :comments , dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports  , dependent: :destroy

  # ===ここからフォロー・フォロワーに関する記述===
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # follower_idを参照
  has_many :followed_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # followed_idを参照
  has_many :followings, through: :follower_relationships, source: :followed # followings = follower_idを経由して followed(user)_id を参照
  has_many :followers , through: :followed_relationships, source: :follower # followers  = followed_idを経由して follower(user)_id を参照
  # ===ここまでフォロー・フォロワーに関する記述===

end
