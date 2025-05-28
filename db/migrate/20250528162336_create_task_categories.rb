class CreateTaskCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :task_categories do |t|
      t.string :name
    end
  end
end
