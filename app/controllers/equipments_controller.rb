class EquipmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  
  def index
    if params[:search]
      @equipments = Equipment.algolia_search(params[:search])
      policy_scope(Equipment)
      if @equipments.empty?
        @equipments = policy_scope(Equipment).order(:created_at)
        flash[:notice] = "Product not found"
      end
    else
      @equipments = policy_scope(Equipment).order(:created_at)
    end


    @users = User.geocoded # returns equipments with coordinates

    @markers = @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { user: user })
      }
    end
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
    @equipment.user = current_user

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
