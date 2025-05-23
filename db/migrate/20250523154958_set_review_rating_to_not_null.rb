class SetReviewRatingToNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :reviews, :rating, false
  end
end
