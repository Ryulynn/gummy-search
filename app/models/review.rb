class Review < ApplicationRecord
  belongs_to :user
  belongs_to :gummy
  validates :comment, presence: true
end
