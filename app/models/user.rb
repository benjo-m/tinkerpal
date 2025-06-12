class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email_address, presence: true, uniqueness: true
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  belongs_to :city
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_many :offers, dependent: :destroy
  has_many :reviews
  has_and_belongs_to_many :skills
end
