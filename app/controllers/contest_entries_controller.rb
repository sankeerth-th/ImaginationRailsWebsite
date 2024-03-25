class ContestEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contest, only: [:new, :create]

  def new
    @contest_entry = ContestEntry.new
  end

  def create
    @contest_entry = ContestEntry.new(contest_entry_params)
    @contest_entry.user = current_user
    @contest_entry.contest = @contest

    if @contest_entry.save
      redirect_to contest_path(@contest), notice: 'Your potion has been submitted to the contest.'
    else
      render :new
    end
  end

  def edit
    @contest = Contest.find(params[:contest_id])
    @contest_entry = @contest.contest_entries.find(params[:id])
    render :edit
  end

  def update
    @contest = Contest.find(params[:contest_id])
    @entry = @contest.contest_entries.find(params[:id])
    puts @entry
    if @entry.update(params.require(:contest_entry).permit(:potion_name, :description, :image))
      flash[:success] = 'Submission was successfully updated.'
      redirect_to contest_entry_url(@contest, @entry)
    else
      flash.now[:error] = 'Unable to update Submission.'
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @contest = Contest.find(params[:contest_id])
    @entries = @contest.contest_entries
    @now = DateTime.now
    render :index
  end

  def show
      @contest = Contest.find(params[:contest_id])
      @entry = @contest.contest_entries.find(params[:id])
      @vote = @entry.contest_votes.where(user_id: current_user.id)
      render :show
  end
  private

  def set_contest
    @contest = Contest.find(params[:contest_id])
  end

  def contest_entry_params
    params.require(:contest_entry).permit(:potion_id, :description, :image, :potion_name, :ingredients, :origin_city)
  end
end
