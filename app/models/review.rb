class Review < ApplicationRecord
  validates :rating, presence: { message: "Rating is required" }
  validates :rating, comparison: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
