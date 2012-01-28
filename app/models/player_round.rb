class PlayerRound < ActiveRecord::Base
  belongs_to :player
  attr_accessible :decade, :mitigation, :adaptation, :gross_national_income, :residual_emissions, :baseline_damage, :residual_damage
end
