class PlayersController < ApplicationController
  def index
    @players = Team.find(params['team_id']).players
  end

  def show
    @player = Player.find(params[:id])
  end

  def join
    @player = Player.new
    @game = Game.find(params['game_id'])
  end

  def new
    @player = Player.new
    @player.team = Team.find(params['team_id'])
  end

  def create
    @player = Player.new(params[:player])
    if params['team_id']
      @player.team = Team.find(params['team_id'])
    end
    if @player.save
      redirect_to stats_player_path(@player), :notice => "Successfully created player."
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
    @player = Player.find(params[:id])
    @current_round = @player.current_round()
    if @current_round
      redirect_to edit_player_player_round_path(@player, @current_round)
    end
  end
end
