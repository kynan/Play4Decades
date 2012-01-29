class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to @game, :notice => "Successfully created game."
    else
      render :action => 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      redirect_to @game, :notice  => "Successfully updated game."
    else
      render :action => 'edit'
    end
  end

  def join
  end

  def authorize
    @game = Game.find(params[:id])
    # FIXME: check that game isn't full etc.
    redirect_to browse_game_teams_path(@game), :notice  => "Successfully joined game."
  end

  def new_round
    @game = Game.find(params[:id])
    @game.teams.each do |t|
      TeamRound.create!(:team => t)
      t.players.each do |p|
        PlayerRound.create!(:player => p)
      end
    end
    redirect_to @game, :notice => "Successfully advanced to next round."
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_url, :notice => "Successfully destroyed game."
  end
end
