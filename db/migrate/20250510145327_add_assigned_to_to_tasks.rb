class AddAssignedToToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :assigned_to, :integer
    add_index :tasks, :assigned_to
  end
end
