class Subscription < ActiveRecord::Base
  attr_accessible  :last_visit_time, :user_id, :question_id
  belongs_to :user
  belongs_to :question
end