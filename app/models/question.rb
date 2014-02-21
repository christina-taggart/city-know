class Question < ActiveRecord::Base
	attr_accessible  :title, :body
	belongs_to :user
	belongs_to :city
  has_many :answers

	validates :title, :presence => true
	validates :body, :presence => true
end