class EquipmentsController < ApplicationController
  def index
  end

  def show
    @equipment = Equipment.find(params[:id])
  end

  def new
  end

  def create
  end

  def update
  end

  private

  def equipment_params
    params.require(:equipment).permit(:name, :description, :price, :photos [])
  end
end
