class TeamsController < ApplicationController
  def index
    @teams = Game.find(params['game_id']).teams
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    game = Game.find(params['game_id'])
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team], :game => Game.find(params['game_id']))
    if @team.save
      redirect_to @team, :notice => "Successfully created team."
    else
      render :action => 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      redirect_to @team, :notice  => "Successfully updated team."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to teams_url, :notice => "Successfully destroyed team."
  end
end
