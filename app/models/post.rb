class Post < ActiveRecord::Base
	attr_accessible  :title, :body
	belongs_to :user
	belongs_to :city

	validates :title, :presence => true
	validates :body, :presence => true
end