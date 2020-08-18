class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    # @equipment = Equipment.find(current_user)
  end
  

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @bookings = @equipment.bookings
    @booking = Booking.new(booking_params)

    @booking.equipment = @equipment

    if @booking.save
      redirect_to equipment_path(@equipment)
    else
      render 'equipment/show'
    end
  end

  def update
  end

  private

  def booking_params
    params.require(:booking).permit(:date)

  def set_user
   
  end
end
