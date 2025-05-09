class AddDateAndTimeToOffers < ActiveRecord::Migration[8.0]
  def change
    add_column :offers, :date, :date
    add_column :offers, :time, :time
  end
end
