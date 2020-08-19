class CreateEquipments < ActiveRecord::Migration[6.0]
  def change
    create_table :equipments do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.boolean :booked, default: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
