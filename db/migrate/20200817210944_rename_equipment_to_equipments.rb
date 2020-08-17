class RenameEquipmentToEquipments < ActiveRecord::Migration[6.0]
  def change
    rename_table :equipment, :equipments
  end
end
