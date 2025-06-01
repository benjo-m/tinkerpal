class CreateSkillsUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :skills_users, id: false do |t|
      t.belongs_to :skill
      t.belongs_to :user
    end
  end
end
