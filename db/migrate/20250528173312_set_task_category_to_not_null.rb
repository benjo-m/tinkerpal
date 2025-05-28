class SetTaskCategoryToNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :tasks, :task_category_id, false
  end
end
