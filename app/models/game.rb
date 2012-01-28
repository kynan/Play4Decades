class Game < ActiveRecord::Base
  has_many :teams
  has_one :admin
  attr_accessible :state, :nrounds
end
