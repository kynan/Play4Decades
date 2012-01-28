class TeamRound < ActiveRecord::Base
  belongs_to :team
  attr_accessible :decade, :temperature, :cumulative_global_co2
end
