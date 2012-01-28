class Team < ActiveRecord::Base
  belongs_to :game
  attr_accessible :name
end
