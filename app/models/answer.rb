class Answer < ActiveRecord::Base
  attr_accessible :body, :vote_count
  validates :body, presence: true
  belongs_to :question
  belongs_to :user
end