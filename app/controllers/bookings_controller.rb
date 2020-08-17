class BookingsController < ApplicationController

  def index
    raise
    @equipment = Equipment.find(current_user)
    @bookings = Booking.all
  end

  def create
  end

  def update
  end

  def set_user
    
  end
end
