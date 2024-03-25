class ContestVotesController < ApplicationController
    before_action :authenticate_user!

    def create
        @contest = Contest.find(params[:contest_id])
        @entry = @contest.contest_entries.find(params[:id])
        @vote = @entry.contest_votes.new()
        current_user.contest_votes << @vote
        if @vote.save
          flash[:success] = 'Your vote has been cast.'
          redirect_back(fallback_location: contest_entry_url(@contest, @entry))
        else
          flash.now[:error] = 'Unable to cast vote.'
          redirect_back(fallback_location: contest_entry_url(@contest, @entry))
        end
    end
    def destroy
        @contest = Contest.find(params[:contest_id])
        @entry = @contest.contest_entries.find(params[:id])
        @vote = @entry.contest_votes.where(user_id: current_user.id).first
        if @vote.destroy
          flash[:success] = 'Your vote has been removed.'
          redirect_back(fallback_location: contest_entry_url(@contest, @entry))
        else
          flash[:error] = 'Unable to remove vote.'
          redirect_back(fallback_location: contest_entry_url(@contest, @entry))
        end
      end
end
