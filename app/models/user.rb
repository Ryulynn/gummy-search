class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_secure_password
  validates :name, presence: true, length: { maximum: 8 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  mount_uploader :image, UserImageUploader
end
