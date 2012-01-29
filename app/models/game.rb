class Game < ActiveRecord::Base
  has_many :teams
  has_one :admin
  validates_uniqueness_of :token

  def current_round
    # FIXME: Do this in a nicer way
    self.teams.first.try(:team_rounds).try(:count) or 0
  end

  def current_year
    2010+(current_round-1)*10
  end

  def forcast_year 
    current_year+10
  end
end
