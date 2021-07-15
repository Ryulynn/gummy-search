class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: {maximum:8}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password_digest, presence: true, length: {minimum:8, maximum:32}
end32
