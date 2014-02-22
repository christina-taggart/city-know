class Question < ActiveRecord::Base
	attr_accessible  :title, :body
	belongs_to :user
	belongs_to :city
  has_many :answers
  has_many :votes, as: :voteable

	validates :title, :body, :presence => true
end