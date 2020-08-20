class User < ApplicationRecord
  has_many :equipments, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :email, uniqueness: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode
  # after_validation :geocode, if: :will_save_change_to_address?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end
end
