class AddOffersCountToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :offers_count, :integer, default: 0, null: false
  end
end
