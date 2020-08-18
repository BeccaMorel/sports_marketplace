class BookingsController < ApplicationController
  def index
    @equipment = Equipment.find(current_user)
    @bookings = Booking.all
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @bookings = @equipment.bookings
    @booking = Booking.new(booking_params)

    @booking.equipment = @equipment
    @booking.user = current_user

    if @booking.save
      redirect_to equipment_path(@equipment)
    else
      render 'equipments/show'
    end
  end

  def update
  end

  private

  def booking_params
    params.require(:booking).permit(:date)
  end

  def set_user

  end
end
