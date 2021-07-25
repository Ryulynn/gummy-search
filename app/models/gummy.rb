class Gummy < ApplicationRecord
  validates :name, presence: true
  validates :image, presence: true
  validates :flavor_id_1, presence: true
end
