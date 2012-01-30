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
    @game.token = rand(36**8).to_s(36)[0..3]
    if @game.save
      # Create two default teams
      @team1 = Team.new(:name => 'Alpha Centauri')
      @team1.game = @game
      @team1.save
      @team2 = Team.new(:name => 'Betelgeuse')
      @team2.game = @game 
      @team2.save

      redirect_to game_team_path(@game), :notice => "Successfully created game."
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
    @game = Game.where(:token => params[:token], :state => 'new').first
    # FIXME: check that game isn't full etc.
    if @game
      redirect_to join_game_players_path(@game), :notice  => "Successfully joined game."
    else
      redirect_to join_games_path, :alert => "There is no open game with that id."
    end
  end

  def start
    @game = Game.find(params[:id])
    @game.state = 'running'
    @game.save!
    redirect_to new_round_game_path(@game), :notice => "Game is starting"
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
