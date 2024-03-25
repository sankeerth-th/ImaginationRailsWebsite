class ContestsController < ApplicationController
  before_action :set_contest, only: %i[ show edit update destroy ]

  # GET /contests or /contests.json
  def index
    #TODO: only show non-ended contests
    @contests = Contest.all
  end

  # GET /contests/1 or /contests/1.json
  def show
    @contest = Contest.find(params[:id])
    @now = DateTime.now
    if @contest.winner_id
      @winner = ContestEntry.find(@contest.winner_id)
    end
    render :show
  end

  # GET /contests/new
  def new
    @contest = Contest.new
  end

  # GET /contests/1/edit
  def edit
    @contest = Contest.find(params[:id])
    render :edit
  end

  # POST /contests or /contests.json
  def create
    @contest = current_user.vendor.contests.build(params.require(:contest).permit(:title, :desc, :image, :end_date))
      if @contest.save
        flash[:success] = 'Contest was successfully updated.'
      redirect_to contest_path(@contest)
      else
        flash.now[:error] = 'Unable to update Contest.'
      render :edit, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /contests/1 or /contests/1.json
  def update
    @contest = Contest.find(params[:id])
    if @contest.update(params.require(:contest).permit(:title, :desc, :image, :end_date))
      flash[:success] = 'Contest was successfully updated.'
      redirect_to contest_path(@contest)
    else
      flash.now[:error] = 'Unable to update Contest.'
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /contests/1 or /contests/1.json
  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy
    flash[:success] = 'Contest was successfully destroyed.'
    redirect_to contests_url
  end

  def winner
    contest = Contest.find(params[:contest_id])
    entry = ContestEntry.find(params[:id])
    contest.winner_id = entry.id
    if contest.end_date > DateTime.now
      contest.end_date = DateTime.now
    end
    if contest.save
      flash[:success] = 'Contest winner was set.'
      redirect_to contest_path(contest)
    else
      flash.now[:error] = 'Unable to set contest winner.'
      redirect_to contest_path(contest)
    end
  end

  def removewinner
    contest = Contest.find(params[:contest_id])
    contest.winner_id = nil
    if contest.save
      flash[:success] = 'Contest winner was removed.'
      redirect_to contest_path(contest)
    else
      flash.now[:error] = 'Unable to remove contest winner.'
      redirect_to contest_path(contest)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contest_params
      params.fetch(:contest, {})
    end
end
