class Post < ApplicationRecord

  has_many   :reports  , dependent: :destroy
  has_many   :comments , dependent: :destroy
  has_many   :favorites, dependent: :destroy
  belongs_to :user

end