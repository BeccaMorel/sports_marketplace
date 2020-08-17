class Booking < ApplicationRecord
  belongs_to :equipment
  belongs_to :user
end
