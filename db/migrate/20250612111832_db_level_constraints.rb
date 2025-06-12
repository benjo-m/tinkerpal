class DbLevelConstraints < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :username, unique: true
    change_column :users, :username, :string, limit: 50
    change_column :tasks, :title, :string, limit: 100
  end
end
