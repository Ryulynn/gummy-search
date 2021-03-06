class Gummy < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :spots, dependent: :destroy
  validates :name, presence: true
  validates :image, presence: true
  validates :flavor_id_1, presence: true
  validates :maker_id, presence: true
  mount_uploader :image, UserImageUploader
end
