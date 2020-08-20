class BookingsController < ApplicationController
  def index
    @message = "None"
    begin
      @equipments_all = policy_scope(Equipment)
      @equipments = @equipments_all.select{|equipment|equipment.user_id == current_user.id }
    rescue ActiveRecord::RecordNotFound
      @equipments = []
    end
    @requests_wait = []
    begin
      @equipments.each do |item|
        Booking.where( equipment_id: item.id, status: "pending" ).each do |booking|
          @requests_wait << booking
        end
      end
    rescue ActiveRecord::RecordNotFound
      @requests_wait = []
    end

    @requests_on = []
    begin
      @equipments.each do |item|
        Booking.where( equipment_id: item.id, status: "in progress" ).each do |booking|
          @requests_on << booking
        end
      end
    rescue ActiveRecord::RecordNotFound
      @requests_on = []
    end

    begin
      @bookings = Booking.where(user_id: current_user)
    rescue ActiveRecord::RecordNotFound
      @bookings = []
    end
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @bookings = @equipment.bookings
    @booking = Booking.new(booking_params)

    @booking.equipment = @equipment
    @booking.user = current_user

    authorize(@booking)

    if @booking.save
      redirect_to equipment_path(@equipment)
    else
      render 'equipments/show'
    end
  end

  def update
    @booking = Booking.find(params[:id])
    status = params[:format]
    booked = status.match? "in progress"
    authorize(@booking)
    @booking.update(status: status)
    @booking.equipment.update(booked: booked)
    redirect_to bookings_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.equipment.booked = false
    authorize(@booking)
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:date)
  end
end
