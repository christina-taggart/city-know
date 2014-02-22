class VotesController < ApplicationController
  def create
    voteable = Question.find(params[:voteable_id])
    vote = voteable.votes.new
    vote.user = current_user
    vote.save
    render :partial => 'question_vote_count', :locals => { :question => voteable }
  end
end