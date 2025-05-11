class Offer < ApplicationRecord
  validates :price, :time, :date, presence: true
  belongs_to :task
  belongs_to :user
  validate :date_and_time_cannot_be_in_the_past

  def date_and_time_cannot_be_in_the_past
    return if date.blank? || time.blank?

    offer_datetime = DateTime.new(date.year, date.month, date.day, time.hour, time.min)
    current_datetime = Time.current

    if offer_datetime < current_datetime
      errors.add(:date_and_time, "must be in the future.")
    end
  end
end
