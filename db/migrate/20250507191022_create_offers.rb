class CreateOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :offers do |t|
      t.text :note
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :status, default: "pending"
      t.belongs_to :task, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
