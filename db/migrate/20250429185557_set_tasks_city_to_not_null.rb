class SetTasksCityToNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :tasks, :city_id, false
  end
end
