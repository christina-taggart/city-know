class VotesController < ApplicationController
  def create
    voteable_type = params[:voteable_type].downcase
    voteable = voteable_type.classify.constantize.find params[:voteable_id]
    vote = voteable.votes.new
    vote.user = current_user
    vote.save
    render :partial => voteable_type + '_vote_count', :locals => { voteable_type.to_sym => voteable }
  end
end