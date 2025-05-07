class Task < ApplicationRecord
  belongs_to :user
  validates :title, :description, presence: true
  belongs_to :city
  has_many_attached :images
  has_many :offers, dependent: :destroy
end
