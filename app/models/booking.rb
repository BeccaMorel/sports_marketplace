class Booking < ApplicationRecord
  belongs_to :equipment
  belongs_to :user
  validates :date, presence: true
  validates_uniqueness_of :equipment_id, scope: :user_id, condition: -> { where(status: "in pending")}
end
