class City < ActiveRecord::Base
  attr_accessible :name, :country, :lat, :long
  validates :name, :country, :lat, :long, presence: true
  has_many :questions
end