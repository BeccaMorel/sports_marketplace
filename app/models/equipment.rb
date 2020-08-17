class Equipment < ApplicationRecord
  has_many :reviews
  has_many :bookings
  has_many_attached :photos
end
