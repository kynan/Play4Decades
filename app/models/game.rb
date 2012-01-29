class Game < ActiveRecord::Base
  has_many :teams
  has_one :admin

  def current_round
    # FIXME: Do this in a nicer way
    self.teams.first.try(:team_rounds).try(:count) or 0
  end

  def current_year
    current_round*10+2010
  end

  def next_decade
    current_year+10
  end
end
