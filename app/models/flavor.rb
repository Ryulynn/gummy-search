class Flavor < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
