class ChangeBookedInEquipments < ActiveRecord::Migration[6.0]
  def change
    change_column :equipments, :booked, :boolean, default: false
  end
end
