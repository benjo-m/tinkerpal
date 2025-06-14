class Offer < ApplicationRecord
  enum :status, [ :pending, :declined, :accepted, :completed ]
  validates :price, :time, :date, presence: true
  belongs_to :task, counter_cache: true
  belongs_to :user
  validate :date_and_time_cannot_be_in_the_past

  scope :current_user_offers, -> { where(user: Current.user).order(created_at: :asc) }

  def date_and_time_cannot_be_in_the_past
    return if date.blank? || time.blank?

    offer_datetime = DateTime.new(date.year, date.month, date.day, time.hour, time.min)
    current_datetime = Time.current

    if offer_datetime < current_datetime
      errors.add(:date_and_time, "must be in the future.")
    end
  end
end
