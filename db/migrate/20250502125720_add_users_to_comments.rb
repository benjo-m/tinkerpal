class AddUsersToComments < ActiveRecord::Migration[8.0]
  def change
    add_reference :comments, :user, null: true, foreign_key: true
  end
end
