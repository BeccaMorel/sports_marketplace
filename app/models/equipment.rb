class Equipment < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  belongs_to :user
  has_many_attached :photos
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
