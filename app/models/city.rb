class City < ActiveRecord::Base
  attr_accessible :name, :description
  validates :name, :description, presence: true
  has_many :questions
end