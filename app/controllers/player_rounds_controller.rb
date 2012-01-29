class PlayerRoundsController < ApplicationController
  def index
    @player_rounds = PlayerRound.all
  end

  def show
    @player_round = PlayerRound.find(params[:id])
  end

  def new
    @player_round = PlayerRound.new
  end

  def create
    @player_round = PlayerRound.new(params[:player_round])
    if @player_round.save
      redirect_to @player_round, :notice => "Successfully created player round."
    else
      render :action => 'new'
    end
  end

  def edit
    @player_round = PlayerRound.find(params[:id])
    @player = @player_round.player 
    @team = @player.team
    @game = @team.game
  end

  def update
    @player_round = PlayerRound.find(params[:id])
    if @player_round.update_attributes(params[:player_round])
      redirect_to edit_player_player_round_path(@player_round.player, @player_round), :notice  => "Successfully updated player round."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @player_round = PlayerRound.find(params[:id])
    @player_round.destroy
    redirect_to player_rounds_url, :notice => "Successfully destroyed player round."
  end
end
