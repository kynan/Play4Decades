class Game < ActiveRecord::Base
  has_many :teams
  has_one :admin
  attr_accessible :state, :nrounds

  def current_round
    # FIXME: Do this in a nicer way
    self.teams.first.try(:team_rounds).try(:count) or 0
  end
end
