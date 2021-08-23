class Contact < ApplicationRecord
  validates :name           , presence: true
  validates :email          , presence: true
  validates :phone_number   , presence: true
  validates :subject        , presence: true
  validates :contact_message, presence: true
end
