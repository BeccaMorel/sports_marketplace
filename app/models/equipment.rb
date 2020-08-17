class Equipment < ApplicationRecord
    has_many :reviews, :bookings
end
