class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  belongs_to :city
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_many :offers, dependent: :destroy
  has_many :reviews
end
