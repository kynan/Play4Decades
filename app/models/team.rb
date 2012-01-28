class Team < ActiveRecord::Base
  belongs_to :game
  has_many :players
  has_many :team_rounds
  attr_accessible :name
end
