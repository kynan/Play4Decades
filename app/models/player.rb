class Player < ActiveRecord::Base
  belongs_to :team
  has_many :player_rounds
end
