class ChangeColumnsInBookings < ActiveRecord::Migration[6.0]
  def change
    change_column :bookings, :status, :string, default: "pending"
    add_column :bookings, :days, :integer, default: 1
  end
end
