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
        @requests_wait = Booking.where( equipment_id: item.id, status: "pending" )
      end
    rescue ActiveRecord::RecordNotFound
      @requests_wait = []
    end

    @requests_on = []
    begin
      @equipments.each do |item|
        @requests_on = Booking.where( equipment_id: item.id, status: "in progress" )
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
    @booking.update(status: status)

    authorize(@booking)

    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:date)
  end

end
