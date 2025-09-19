class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged
  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :password, length: { in: 6..100 }
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  belongs_to :city
  has_many :offers, dependent: :destroy
  has_many :reviews
  has_and_belongs_to_many :skills
end
