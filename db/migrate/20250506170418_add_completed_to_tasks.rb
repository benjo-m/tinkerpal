class AddCompletedToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :completed, :boolean
  end
end
