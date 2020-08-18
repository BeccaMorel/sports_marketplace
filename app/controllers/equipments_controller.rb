class EquipmentsController < ApplicationController
  def index
    @equipments = Equipment.all
  end

  def show
    @equipment = Equipment.find(params[:id])
    @booking = Booking.new
    @bookings = @equipment.bookings
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.user_id = current_user.id
    #@equipment.user = current_user
    if @equipment.save
      redirect_to equipment_path(@equipment)
    else
      render :new
    end
  end

  def update
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy
      redirect_to equipments_path
  end

  private

  def equipment_params
    params.require(:equipment).permit(:name, :description, :price, photos: [])
  end
end
