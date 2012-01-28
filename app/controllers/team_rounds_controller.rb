class TeamRoundsController < ApplicationController
  def index
    @team_rounds = TeamRound.all
  end

  def show
    @team_round = TeamRound.find(params[:id])
  end

  def new
    @team_round = TeamRound.new
  end

  def create
    @team_round = TeamRound.new(params[:team_round])
    if @team_round.save
      redirect_to @team_round, :notice => "Successfully created team round."
    else
      render :action => 'new'
    end
  end

  def edit
    @team_round = TeamRound.find(params[:id])
  end

  def update
    @team_round = TeamRound.find(params[:id])
    if @team_round.update_attributes(params[:team_round])
      redirect_to @team_round, :notice  => "Successfully updated team round."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @team_round = TeamRound.find(params[:id])
    @team_round.destroy
    redirect_to team_rounds_url, :notice => "Successfully destroyed team round."
  end
end
