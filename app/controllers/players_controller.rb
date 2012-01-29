class PlayersController < ApplicationController
  def index
    @players = Team.find(params['team_id']).players
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
    @player.team = Team.find(params['team_id'])
  end

  def create
    @player = Player.new(params[:player])
    @player.team = Team.find(params['team_id'])
    if @player.save
      redirect_to player_path(@player), :notice => "Successfully created player."
    else
      render :action => 'new'
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      redirect_to @player, :notice  => "Successfully updated player."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_url, :notice => "Successfully destroyed player."
  end

  def stats
  end
end
