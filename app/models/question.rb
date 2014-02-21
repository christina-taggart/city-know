class Question < ActiveRecord::Base
	attr_accessible  :title, :body
	belongs_to :user
	belongs_to :city
  has_many :answers

	validates :title, :body, :presence => true
end