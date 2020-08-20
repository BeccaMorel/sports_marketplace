class ReviewsController < ApplicationController
    before_action :set_equipment
    def new
        @review = Review.new
        authorize(@review)
    end

    def create
      @review = Review.new(review_params)
      @review.user_id = current_user.id
      @review.equipment_id = @equipment.id
      
      @review.booking_id = params[:booking_id]
      authorize(@review)

      if @review.save
        redirect_to bookings_path
      else
        render :new
      end
    end

    private
    def review_params
        params.require(:review).permit(:title, :description, :rating)
    end
    def set_equipment
        @booking = Booking.find(params[:booking_id])
        @equipment = @booking.equipment
    end
end
