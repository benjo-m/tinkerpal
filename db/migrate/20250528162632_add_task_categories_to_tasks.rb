class AddTaskCategoriesToTasks < ActiveRecord::Migration[8.0]
  def change
    add_reference :tasks, :task_category, foreign_key: true
  end
end
