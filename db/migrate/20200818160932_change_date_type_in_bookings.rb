class ChangeDateTypeInBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :date
    add_column :bookings, :date, :datetime
  end
end
