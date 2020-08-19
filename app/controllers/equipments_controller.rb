class EquipmentsController < ApplicationController
  def index
    @equipments = policy_scope(Equipment).order(:created_at)
  end

  def show
    @equipment = Equipment.find(params[:id])
    @booking = Booking.new
    @bookings = @equipment.bookings
    authorize(@equipment)
  end

  def new
    @equipment = Equipment.new
    authorize(@equipment)
  end

  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.user_id = current_user.id

    authorize(@equipment)
    
    if @equipment.save
      redirect_to equipment_path(@equipment)
    else
      render :new
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])
    authorize(@equipment)
  end

  def update
    @equipment = Equipment.find(params[:id])
    @equipment.update(equipment_params)
    authorize(@equipment)
    redirect_to equipment_path(@equipment)
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    authorize(@equipment)
    @equipment.destroy
      redirect_to equipments_path
  end

  private

  def equipment_params
    params.require(:equipment).permit(:name, :description, :price, photos: [])
  end
end
