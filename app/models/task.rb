class Task < ApplicationRecord
  belongs_to :user
  validates :title, :description, presence: true
  belongs_to :city
  has_many :comments
  has_many_attached :images
end
