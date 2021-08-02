class Spot < ApplicationRecord
  belongs_to :user
  belongs_to :gummy
  validates :shop, presence: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode
end
