class AddCityToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :city, null: true, foreign_key: true
  end
end
