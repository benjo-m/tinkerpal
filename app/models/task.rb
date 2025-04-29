class Task < ApplicationRecord
  belongs_to :user
  validates :title, :description, presence: true
  belongs_to :city
end
