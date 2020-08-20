class Equipment < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  belongs_to :user
  has_many_attached :photos
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  include AlgoliaSearch

  algoliasearch do
    attributes :name, :description, :price
    add_attribute :extra_attr
    searchableAttributes ['name', 'description', 'extra_attr']
  end
  def extra_attr
    self.user.first_name
  end
end
