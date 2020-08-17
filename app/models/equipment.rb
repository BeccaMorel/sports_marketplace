class Equipment < ApplicationRecord
    has_many :reviews
    has_many :bookings
end
