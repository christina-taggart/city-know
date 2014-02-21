class City < ActiveRecord::Base
  validates :name, :description, presence: true
  has_many :posts
end