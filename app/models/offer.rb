class Offer < ApplicationRecord
  validates :price, presence: true
  belongs_to :task
  belongs_to :user
end
