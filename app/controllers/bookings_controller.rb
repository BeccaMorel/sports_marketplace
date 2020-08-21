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
      @bookings = []
      Booking.where(user_id: current_user).each do |booking|
        @bookings << booking unless booking.status == "canceled"
      end
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
    unless @bookings.find{|book| book.equipment_id = params[:equipment_id] && book.user_id == current_user.id && book.status == "pending"}
      if @booking.save
        redirect_to equipment_path(@equipment)
        flash[:notice] = "Request made to #{User.find(@equipment.user_id).first_name}! Go to Dashboard to see status"
      else
        flash.now[:notice] = "Request could not be made. Please try again"
        render 'equipments/show'
      end
    else
      flash.now[:notice] = "Request already made. Go to Dashboard to see status"
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

  private

  def booking_params
    params.require(:booking).permit(:date)
  end
  def authorized_booking
    @equipment.bookings.find {|book| 
      book.equipment_id = params[:equipment_id] && 
      book.user_id = @booking.user.id && book.status != "canceled"}
  end

end
